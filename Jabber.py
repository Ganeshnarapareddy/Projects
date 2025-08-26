import paramiko
import time
import logging
import os
import sys
import datetime
import re
from pykeepass import PyKeePass


folder = "Reports" + str(int(datetime.datetime.now().timestamp()))
keepass = []
def get_script_path():
    return os.path.dirname(os.path.realpath(sys.argv[0]))

def run_shell_command(host, cli_user, cli_password, customer):
  
    client_ssh = paramiko.SSHClient()
    client_ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client_ssh.connect(host, port=22, username=cli_user, password=cli_password, banner_timeout=300)
    shell = client_ssh.invoke_shell()
    print("Connected to CLI of host : {0} ".format(host))
    time.sleep(12)

    try:
        shell.send("run pe sql ttlogin select * from clientsessions")
        shell.send("\n")
        time.sleep(20)
        logging.info("Running shell command : utils disaster_recovery status backup on host {0}".format(host))
        print("I already slept for 10 seconds ")
        #shell.send("show version active")
        #shell.send("\n")
        #time.sleep(10)
        output = shell.recv(5000000000000)
        print(output)
		#logging.info(output)
        write_file(output, customer)
    except Exception as e:
        logging.info(e)
        logging.info("Error in running commands  on host : {0} ".format(host))
        


def write_file(output, customer):
    print("Writing to a file output for cst: {}".format(customer))
    filename = os.path.join(get_script_path(), "Reports", folder, "sql.txt")
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    with open(filename, 'a') as fw:
        fw.write("*********************************\n\n")
        fw.write("output for cst: {}".format(customer))
        if output:
            for line in str(output).split("\\r\\n"):
                fw.write(str(line))
                fw.write("\n")
        else:
            fw.write("Failed to execute command and capture output")
        fw.write("*********************************\n\n")

def write_logs(output,customer):
    print("Writing to a file output for cst: {}".format(customer))
    filename = os.path.join(get_script_path(), "Reports", folder, "Cucm.txt")
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    group = re.search(r"Status:", str(output))
    with open(filename, "a") as fw:
          fw.write("*********************************\n\n")
          fw.write("Writing logs for Customer {} \n".format(customer))
          line_no = 1
          if group:
              if output:
                  for line in str(output).split("\\r\\n"):
                      var1 = "Status:"
                      var2 = "Tar Filename:"
                      if var1 in line or var2 in line:
                          fw.write(str(line))
                          fw.write("\n")





          elif "Timed_out" in str(output):
              fw.write(r"Timed_out while trying to execute command")
          else:
              fw.write("Failed to execute command and capture output")
          fw.write("*********************************\n\n")

def read_keepass():
    import glob
    script_directory = get_script_path()
    logging.info(" Script directory is : {} \n ".format(script_directory))
    keepass_diretory = os.path.join(script_directory, "keepass")
    files = glob.glob(os.path.join(keepass_diretory, "*.kdbx"))
    logging.info(" Found keepass files :  {}\n ".format(files))
    for file in files:
        logging.info("Working on keepass file : {} \n".format(file))
        print("Working on keepass file : {} \n\n".format(file))
        p = input(
            "Enter password for keepass(if you want to skip this keepass press enter without entering password) : {}     ".format(
                file))
        if p:
            try:
               kp = PyKeePass(file, password=p)
               keepass.append(kp)
            except:
                logging.info("Could not open keepass file : {}\n".format(file))
                continue
        else:
            continue




def main():

    read_keepass()
    for key in keepass:
        grps = key.find_groups(name='[A-Z]*[a-z]*CUP', regex=True)
        for grp in grps:
            try:
                print("\n\n Working on Customer : {}".format(grp))
                logging.info("Working on Customer : {}".format(grp))
                cust = grp.path
                entry = key.find_entries(path=cust + '/', title='[A-Z]*[a-z]*_?PUB.*-.*CLI', first=True, regex=True)
                host = entry._get_string_field('NAT IP')
                host = host.strip()
                host_username = entry.username
                host_password = entry.password
                logging.info(" working for Customer : {0} using host : {1} ".format(cust, host))
                print("host : ",host, "username : ", host_username,"password",host_password, "cust", cust)
                run_shell_command(host, host_username, host_password, cust)
                logging.info("Completed tasks for Customer : {} \n".format(cust))
            except Exception as e:
                logging.info(e)

log = "JABAR-VERSION" + str(datetime.datetime.now().strftime('_%H_%M_%d_%m_%Y')) + ".txt"
log_file = os.path.join(get_script_path(), "log", log)
logging.basicConfig(filename=log_file, level=logging.INFO)
logging.getLogger("paramiko").setLevel(logging.WARNING)

logging.info(" Starting program run_cli_commands \n")
main()
