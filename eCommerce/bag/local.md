#### 1. Set correct endpoint in `.env`

Make sure your `.env` has both:

```env
APP_URL=http://192.168.100.6:8000
GRAPHQL_ENDPOINT=http://192.168.100.6:8000/graphql
```

Then clear config cache:

```bash
php artisan config:clear
php artisan cache:clear
```

---

#### 2. Double-check routes

Confirm that `/graphql` route is actually registered:

```bash
php artisan route:list | grep graphql
```

You should see something like:

```
POST    graphql
GET|POST  graphiql
```

If `/graphql` isn’t there → maybe `bagisto-graphql:install` didn’t run properly. Run it again:

```bash
php artisan bagisto-graphql:install
```

---

#### 3. CORS issues

If `/graphql` exists but GraphiQL can’t reach it, check `config/cors.php`.
Make sure it allows requests from your LAN host (`192.168.100.6:8000`). For testing, you can set:

```php
'paths' => ['api/*', 'graphql', 'graphiql'],
'allowed_origins' => ['*'],
'allowed_methods' => ['*'],
'allowed_headers' => ['*'],
```

Then clear config again:

```bash
php artisan config:clear
```

---

#### 4. Test `/graphql` directly

From your browser (on same device or another LAN device), go to:

```
http://192.168.100.6:8000/graphql
```

It should return something like:

```json
{
  "errors": [
    {
      "message": "GraphQL query must be present in the request"
    }
  ]
}
```

👉 If you see this, it means the endpoint works fine (GraphiQL just wasn’t pointing correctly).

---

### 🔎 Likely cause in your case

Since `/graphiql` loads but fails with `NetworkError`, 99% it’s because your `.env` still has something like:

```env
GRAPHQL_ENDPOINT=http://localhost:8000/graphql
```

So when you open `http://192.168.100.6:8000/graphiql` from another device, the GraphiQL UI still tries to call `http://localhost:8000/graphql` — which doesn’t exist on that device.

---

👉 Fix: Change it to

```env
GRAPHQL_ENDPOINT=http://192.168.100.6:8000/graphql
```

---
