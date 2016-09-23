# kube-simple

This repo contains a list of Terraform modules to deploy kubernetes.

Goals:
- **simple**: no need to download a 1GB+ repo before you can do anything.
- **documented**: as always, compromises are made, todos are marked. We'll be honest about it and make sure you know it.
- **easy to customize**: everything is declarative. No need to dive into some ghastly go code and sigh on things you can't change.
- **maintain**: Thanks to Terraform, it's easy to know the current state of your infrastructure, what changes are to be made and even build a graph of resource dependency.

## Project Structure

The project is divided into 2 parts:
- `modules`: building blocks for a cluster, like CoreOS cloud-config, instance profiles, security groups, etc.
- `integrated`: a list of common architectures, from simple single-public-subnet to multi-az-public-plus-private-subnets, etc.

To get the highest level of customization, use `modules` to make rolling out your own solutions easier.

To quickly setup a cluster, try `integrated`.

## Usage

Simply reference us in your main.tf:

    module "cloudconfig" {
      source = "github.com/luckybuyer/kube-simple//modules/cloudconfig"
      # variables goes here
    }

Note the double-slash is required. Then:

    # get dependencies
    $ terraform get
    # see what's going to happen
    $ terraform plan
    # and make it happen
    $ terraform apply
