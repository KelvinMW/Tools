 1. Resize the Disk (if you haven't already):

    Using the Google Cloud Console:
        Go to the Compute Engine section in the Google Cloud Console.
        Click on "Disks" under the "Storage" section.
        Find the disk you resized and click its name.
        Click the "Edit" button at the top of the disk details page.
        Enter the new desired size in the "Size" field.
        Click "Save". 
    Using the gcloud command-line tool:

Generated code may be subject to license restrictions not shown here. Use code with care. Learn more

    Replace DISK_NAME with the name of your disk, DISK_SIZE with the new size in GB (e.g., 100GB ), and ZONE with the zone where your VM and disk are located. 

2. Connect to your Debian VM:

Use SSH to connect to your virtual machine instance. You can do this through the Cloud Console or your preferred SSH client.

3. Install cloud-guest-utils :

This package provides the growpart utility, which is helpful for resizing partitions.

Generated code may be subject to license restrictions not shown here. Use code with care. Learn more

4. Identify your disk and partition:

Use the lsblk command to list block devices and their partitions:

Generated code may be subject to license restrictions not shown here. Use code with care. Learn more

Look for your disk (usually /dev/sda if it's the boot disk) and the partition you want to resize (often /dev/sda1 ). Take note of these.

5. Resize the partition:

Use the growpart command to expand the partition to fill the available space.

Generated code may be subject to license restrictions not shown here. Use code with care. Learn more

This command tells the kernel about the new partition size. Note that there's a space between /dev/sda and 1 .

6. Resize the file system:

Now that the partition is resized, you need to resize the file system to use the new space. Since you're using Debian, it's likely ext4 . Use resize2fs for this:

Generated code may be subject to license restrictions not shown here. Use code with care. Learn more 


gcloud compute disks resize DISK_NAME --size DISK_SIZE --zone ZONE

sudo apt update
sudo apt install -y cloud-guest-utils
lsblk

sudo growpart /dev/sda 1

sudo resize2fs /dev/sda1
