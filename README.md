# Tofino Model VM

This project is a Vagrant configuration for provisioning a virtual machine
containing the Intel® Tofino™ Model with related applications, specifically for
use with the Virtual Box hypervisor.

This is mainly designed for developers who wish to target Tofino with the BfRt 
gRPC interface without the use of a physical switch, specifically with a view of
targeting academia and research, where the use of gRPC is most highly leveraged.

The philosophy here is that abstractions are avoided where possible, but the
model itself is treated as a closed box.

For the full documentation, see [docs/index.md]()
