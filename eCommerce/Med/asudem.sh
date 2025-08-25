npx medusa db:create --db testdb
npx medusa db:migrate
npx medusa user -e admin@ecommerce.com -p supersecret
npx medusa exec ./src/scripts/seed.ts
