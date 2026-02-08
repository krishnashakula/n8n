# n8n Deployment on Render

This project deploys [n8n](https://n8n.io/), a powerful workflow automation tool, on Render cloud platform.

## Features

- 🚀 One-click deployment to Render
- 🗄️ PostgreSQL database for data persistence
- 🔒 Basic authentication enabled
- 🌐 HTTPS enabled by default
- ⚡ Automatic SSL certificate

## Prerequisites

- A [Render](https://render.com) account (free tier available)
- A GitHub account (to fork/push this repository)

## Deployment Steps

### Option 1: Using render.yaml (Recommended)

1. **Push this code to GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin YOUR_GITHUB_REPO_URL
   git push -u origin main
   ```

2. **Deploy on Render**
   - Go to [Render Dashboard](https://dashboard.render.com/)
   - Click "New" → "Blueprint"
   - Connect your GitHub repository
   - Render will automatically detect `render.yaml` and create:
     - A web service for n8n
     - A PostgreSQL database

3. **Configure Environment Variables**
   
   After deployment, set these required environment variables in Render dashboard:
   
   - `N8N_HOST`: Your Render service URL (e.g., `your-app-name.onrender.com`)
   - `VUE_APP_URL_BASE_API`: `https://your-app-name.onrender.com/`
   - `WEBHOOK_URL`: `https://your-app-name.onrender.com/`
   - `N8N_BASIC_AUTH_USER`: Your desired username
   - `N8N_BASIC_AUTH_PASSWORD`: Your desired password (use a strong password!)

### Option 2: Manual Deployment

1. **Create a new Web Service on Render**
   - Go to Render Dashboard
   - Click "New" → "Web Service"
   - Connect your repository
   - Configure:
     - **Name**: Choose a name (e.g., n8n-app)
     - **Environment**: Node
     - **Build Command**: `npm install`
     - **Start Command**: `npm start`
     - **Plan**: Free or Starter

2. **Create a PostgreSQL Database**
   - Click "New" → "PostgreSQL"
   - Name it (e.g., n8n-db)
   - Select a plan (Free tier available)

3. **Add Environment Variables**
   
   In your Web Service settings, add:
   
   ```
   N8N_HOST=your-app-name.onrender.com
   N8N_PORT=10000
   N8N_PROTOCOL=https
   VUE_APP_URL_BASE_API=https://your-app-name.onrender.com/
   WEBHOOK_URL=https://your-app-name.onrender.com/
   GENERIC_TIMEZONE=America/New_York
   
   # Authentication
   N8N_BASIC_AUTH_ACTIVE=true
   N8N_BASIC_AUTH_USER=your_username
   N8N_BASIC_AUTH_PASSWORD=your_secure_password
   
   # Database (get these from your PostgreSQL database info)
   DB_TYPE=postgresdb
   DB_POSTGRESDB_HOST=your-db-host
   DB_POSTGRESDB_PORT=5432
   DB_POSTGRESDB_DATABASE=n8n
   DB_POSTGRESDB_USER=your-db-user
   DB_POSTGRESDB_PASSWORD=your-db-password
   
   # Encryption (generate a random string)
   N8N_ENCRYPTION_KEY=your-random-encryption-key
   ```

## Accessing n8n

Once deployed, access your n8n instance at:
```
https://your-app-name.onrender.com
```

Login with the credentials you set in `N8N_BASIC_AUTH_USER` and `N8N_BASIC_AUTH_PASSWORD`.

## Important Notes

- **Free Tier Limitations**: Render's free tier spins down after 15 minutes of inactivity, causing a delay on the first request.
- **Persistent Storage**: The PostgreSQL database ensures your workflows and credentials persist across restarts.
- **Security**: Always use strong passwords and consider additional security measures for production use.
- **Encryption Key**: Generate a secure random string for `N8N_ENCRYPTION_KEY`. Never commit this to version control.

## Configuration Options

### Timezone
Change `GENERIC_TIMEZONE` to your preferred timezone:
```
GENERIC_TIMEZONE=Europe/London
GENERIC_TIMEZONE=Asia/Tokyo
```

### Disable Basic Auth (Not Recommended)
If you want to disable basic authentication:
```
N8N_BASIC_AUTH_ACTIVE=false
```

### Custom Domain
You can add a custom domain in Render's dashboard under "Settings" → "Custom Domain".

## Troubleshooting

### Service Won't Start
- Check that all required environment variables are set
- Verify database connection details
- Check Render logs for specific errors

### Can't Login
- Verify `N8N_BASIC_AUTH_USER` and `N8N_BASIC_AUTH_PASSWORD` are set correctly
- Ensure `N8N_BASIC_AUTH_ACTIVE=true`

### Workflows Not Persisting
- Confirm PostgreSQL database is properly connected
- Check database environment variables

## Upgrading n8n

To upgrade to the latest n8n version:

1. Update the version in `package.json`:
   ```json
   "dependencies": {
     "n8n": "^1.XX.0"
   }
   ```

2. Commit and push changes. Render will automatically redeploy.

## Resources

- [n8n Documentation](https://docs.n8n.io/)
- [Render Documentation](https://render.com/docs)
- [n8n Community Forum](https://community.n8n.io/)

## License

MIT

## Support

For issues specific to n8n, visit [n8n GitHub](https://github.com/n8n-io/n8n)
For Render-related issues, contact [Render Support](https://render.com/docs/support)
