# firebase android
## 添加指纹
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

# Server
```bash
brew install php
brew install composer
composer create-project laravel/laravel server-app
php artisan key:generate
php artisan serve
# laravel admin
composer require encore/laravel-admin:1.8.19
php artisan vendor:publish --provider="Encore\Admin\AdminServiceProvider"
php artisan admin:install
```