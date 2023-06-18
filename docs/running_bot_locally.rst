.. _running_bot_locally:

****************************
Running Discord Bot Locally
****************************
So now we should have everything we need to start testing our bot code locally and ensure it works how we want it to.  For this process I've opted to use Docker-Compose to bring up the redis and node containers required for this to work.

Please ensure you have Docker and Docker-Compose setup/installed before continuing.

Doppler Setup Locally
---------------------
So in the previous section we opted to use Doppler for our secrets, this allows us to also use the secrets locally without having to expose them.  In order to do this, you need to ensure you have the Doppler CLI installed via the instructions `Here <https://docs.doppler.com/docs/install-cli>`_

For the next steps we are assuming you already installed the CLI and performed the ``doppler login`` command.

Now you can run ``doppler setup`` and pick your project from the list and select ``dev`` for the environment and it will automatically inject your secrets into Docker for you.

After this you should be able to just run the following to spin everything up:

``doppler run -- docker-compose up -d``

At this point if everything worked ok, you should be able to talk to your character in any of the Discord channels.  I recommend setting up permissions in such a way that this character can only post in certain channels so you don't have to worry about where it responds.