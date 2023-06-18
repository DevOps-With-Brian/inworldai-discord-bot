*****************************
Deploying Bot in Production
*****************************
So you have a few options here to deploy this in production, you can basically run this on a virtual machine if desired and then use the same docker-compose setup there.

Another option is to run this in kubernetes, the good thing about how this works, is there isn't any public endpoint that is being hit, instead the bot is connecting into Discord and listening, so you can setup SSL but if made private shouldn't be a big concern.

This entire stack can work privately without any external allowed ports/etc to communicate to it with a basic configuration.

No matter which option you pick, I recommend using the terraform code included to setup your infrastructure, I have included a vm setup intially using `Linode <https://www.linode.com/lp/refer/?r=24202434814cd6f94325c26c8a78803a931bed0f>`_


Deploying With Docker-Compose on Virtual Machine
------------------------------------------------
For the first option we are going to setup a Linode resource which is basically a virtual machine, and we will run our docker setup here.  It should basically mirror the same process you already performed locally to run it after the vm is up and has all the pre-reqs.

There is a included ``terraform`` directory that you can use to set this up appropriately.

Terraform Deployment
`````````````````````
This project can use `Terraform <https://www.terraform.io/>`_ for our Infrastructure as Code to deploy our Virtual Machine that we run the docker-compose setup on.


Installing Terraform
''''''''''''''''''''
You can install terraform via the docs `Terraform Install <https://developer.hashicorp.com/terraform/downloads>`_, currently this project uses version ``1.5.0``

Doppler With Terraform
'''''''''''''''''''''''
We are using `Doppler <https://docs.doppler.com/docs/terraform>`_ for our variables and storing our secrets, this why our Terraform code doesn't have a tfvars file, etc.  You can look more into this `Here <https://docs.doppler.com/docs/terraform>`_

As the doc mentions we will need to create `Service Token <https://docs.doppler.com/docs/service-tokens>`_ and then we can put this in our existing Doppler project where we have our Inworld secrets and such already stored, and use that project for the terraform deployment as well.  When you generate this token, make sure you do it for the existing project you setup in Doppler so it has access to get the variables.

I have followed the doc and ran the ``doppler configs tokens create token-name --plain`` command to setup a token that the CLI has access to, thus terraform will.

So now we need to take that value and export it as a Terraform Var,  ``export TF_VAR_doppler_token`` that will be used by terraform to get the variables/secrets.

You will also want to add into Doppler in the prd project the ``ROOT_PASS`` variable and ``AUTH_KEY`` which should be what you want the root PW to be and your ssh public key to be able to passwordless ssh in.

Linode API Token
''''''''''''''''''
We also need to setup a ``LINODE_TOKEN`` in Doppler to be used to deploy resources, you can go `Linode API Token Creation <https://cloud.linode.com/profile/tokens>`_ and login and create an API token with at least the following permissions:

Read Only:

.. parsed-literal::

    Images

Read/Write:

.. parsed-literal::

    Account
    Events
    Firewalls
    IPs
    Linodes
    Object Storage
    Volumes

Once this has been created you can store this in the Doppler project in prod as ``LINODE_TOKEN``.


Running The Terraform
''''''''''''''''''''''
Now we should be able to run ``terraform init`` and it should login to doppler and setup our vars and everything should be happy.

Then you can run ``terraform plan`` to ensure everything looks correct, if so then run ``terraform apply`` to deploy the virtual machine.

Now you should have a virtual machine that you should be able to login to via the ``ssh root@ip_here`` that is in the Linode console, it won't use a password it should use your authorized_key that you provided.

You can use the provided ``vm_setup.sh`` in the root of the repo after cloning it down to setup the virtual machine with all the required pre-req's.  Then you just follow the existing docs for :ref:`running_bot_locally`, please make sure you select ``prd`` as the environment not ``dev`` now.

You would just need to clone/download your source code into the vm before running the ``docker-compose`` command as a FYI.

Deploying on Kubernetes
-----------------------
TODO, more coming, if interested there are already some kubernetes manifest files in the ``argocd`` directory.