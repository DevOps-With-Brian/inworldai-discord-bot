import { Session } from '@inworld/nodejs-sdk';
import { createClient } from 'redis';

export class Storage {
  private redisClient = createClient({
    socket: {
        host: process.env.REDIS_HOST || 'redis',
        localPort: 6379,
    }
  });

  async connect({ onError }: { onError?: (err: Error) => void }) {
    await this.redisClient.connect();

    this.redisClient.on('error', (error) => {
      console.error(`Redis client error: ${error}`);
    });

    this.redisClient.on('ready', () => {
      console.log('Redis client is ready!');
    });

    this.redisClient.on('connect', () => {
      console.log('Redis client connected!');
    });

    this.redisClient.on('reconnecting', () => {
      console.log('Redis client is reconnecting...');
    });

    if (onError) {
      this.redisClient.on('error', onError);
    }
  }

  disconnect() {
    this.redisClient.disconnect();
  }

  async get(key: string): Promise<Session | undefined> {
    const json = await this.redisClient.get(key);
  
    if (json !== null) {
      return Session.deserialize(json);
    }
  
    return undefined;
  }
  

  set(key: string, entity: Session) {
    this.redisClient.set(key, Session.serialize(entity));
  }

  delete(key: string) {
    this.redisClient.del(key);
  }
}