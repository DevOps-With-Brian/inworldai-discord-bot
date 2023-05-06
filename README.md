# inworldai-discord-bot
A chatbot setup with eventual deployment for inworldai discord chatbot.

# Initial Setup
So the initial setup requires you have `yarn` installed as well as a way to manage your secrets/tokens.  We are currently using [Doppler](https://doppler.com/join?invite=524473B9) to manage our secrets so the instructions will be based off that, its free to use and is typically easier.

## Discord Token/Server Setup
You will need to setup a bot token for discord, you can follow the https://discord.com/developers/docs/getting-started for more information on this.  The general gist is you setup a new app, make it a bot, give it the permissiosn required and that will generate a token.  This bot token will be `DISCORD_BOT_TOKEN` in Doppler.

## Inworld Secret/Setup
You will want to go into the inworld studio and go to the `integrations` section and click on the API Keys area and generate a Key and Secret.  These will be `INWORLD_KEY` and `INWORLD_SECRET` you setup in Doppler.

You also will need to setup a scene and use that scene ID  which you can get from the browser URL it should be like `workspaces/default-xxxx/scenes/scene_name` for `INWORLD_SCENE` which will go into Doppler as well.


# Docker Compose Locally
So you can run this all via `doppler run -- docker-compose up -d` to bring both redis and the inworld ai app up.  At this point you should now be able to talk to your bot in discord.

# Running in Kubernetes
Currently I'm using ArgoCD to deploy my manifest files in the `argocd` folder, this is also using the https://docs.doppler.com/docs/kubernetes-operator for the secrets part.  It should just be a matter of applying the yaml files and it should all come up and just work.