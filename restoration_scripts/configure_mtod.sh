
# Configure motd
configure_motd () {
    # Make sure you have the PrintMotd option set to yes in your sshd config.
    # if use 40-fail2ban, you should comment out the compress option in /etc/logrotate.d/fail2ban, s.t. the logs are not compressed and can be grepped.
    sudo rm /etc/update-motd.d/* -r          # borro configuracion anterior
    sudo cp motd/* /etc/update-motd.d/ -f    # copio la configuracion
    sudo chmod a+x /etc/update-motd.d/*      # doy permiso de ejecucion  
}


configure_motd