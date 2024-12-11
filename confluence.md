## Backup and Restore Documentation for Nagios XI

### Backup Nagios XI System

The Nagios XI backup process can be performed either through the web-based admin interface or via the command line. Backups should be stored in an external disk drive mounted at `/data` instead of the default backup directory (`/store/backups/nagiosxi/`).

#### Backup Methods

1. **Using the Nagios XI Admin Page (Manual Backup)**
   - Log in to the Nagios XI web interface.
   - Navigate to the **Admin** section.
   - Select **System Backups** and follow the instructions to create a backup.

2. **Using the Command Line**
   - Execute the following command:
     ```bash
     /usr/local/nagiosxi/scripts/backup_xi.sh
     ```
   - By default, this script saves backups to `/store/backups/nagiosxi/`. To direct the backup to the external drive, specify `/data` as the destination. For example:
     ```bash
     /usr/local/nagiosxi/scripts/backup_xi.sh -d /data
     ```

#### Backup Overview

The backup script saves a copy of the following components:
- **Nagios Core files**: `/usr/local/nagios/`
- **Nagios XI files**: `/usr/local/nagiosxi/`
- **MRTG files**: `/var/lib/mrtg/` and `/etc/mrtg/`
- **NRDP files**: `/usr/local/nrdp/`
- **NagVis files**: `/usr/local/nagvis/`
- **CRON files**: `/var/spool/cron/apache`
- **Apache configuration files**: `/etc/httpd/conf.d/`
- **Logrotate configuration files**: `/etc/logrotate.d/`
- **MySQL databases**: `nagios`, `nagiosql`, `nagiosxi`

Backup files are named based on the Unix timestamp at the time of creation, e.g., `1479858002.tar.gz`.

#### Important Note:
Always ensure that the external drive is mounted at `/data` before performing the backup. Verify the mount status with:
```bash
mount | grep /data
```

### Restore Nagios XI System

To restore a Nagios XI system from a backup stored on the external drive:

#### Steps to Restore

1. **Deploy Nagios XI Using Terraform**
   - Use Terraform to deploy a fresh instance of Nagios XI.
   - Ensure the external drive is mounted at `/data`.

2. **Run the Restore Script**
   - Execute the restore script with the backup file:
     ```bash
     /usr/local/nagiosxi/scripts/restore_xi.sh /data/<backupfile>.tar.gz
     ```

3. **Post-Restore Configuration**
   - Update the Nagios XI IP address:
     - Navigate to **Admin > System Config Settings**.
     - Ensure the **Program URL** and **External URL** are updated with the new IP address.
   - Verify license information:
     - Go to **Admin > System Config > License Information**.
     - Ensure the system is licensed.
   - Reconfigure agents/clients:
     - Update agents (e.g., NRPE) to allow connections from the new IP address.

#### Scenarios for Using the Restore Script
The restore script can be used in the following scenarios:
- Restoring a Nagios XI server after a failure or crash (on the same or a different server).
- Migrating Nagios XI between:
  - Different server types:
    - Physical to Physical
    - Physical to Virtual
    - Virtual to Virtual
    - Virtual to Physical
  - Different server versions and architectures, such as:
    - CentOS 7 to CentOS Stream 9
    - CentOS 7.x x86 to RHEL 9.x x86_64
    - CentOS 7.x x86_64 to Ubuntu 22.04 LTS x86_64

