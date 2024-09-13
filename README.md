Got it! Here’s how you can add a section to explain that the app is integrated with Firebase Crashlytics:

---

# KLONTONG

## 1. Login Page

- **Username:** `admin`
- **Password:** `password`

### Screenshot
![Login Screen](https://github.com/naneps/klontong/blob/main/docs/login.png?raw=true)

## 2. Management Product

#### 2.1. Create Product

![Create Product](https://github.com/naneps/klontong/blob/main/docs/create_product.png?raw=true)

#### 2.2. List Product

![List Product](https://github.com/naneps/klontong/blob/main/docs/product_list.png?raw=true)

#### 2.3. Detail Product

![Detail Product](https://github.com/naneps/klontong/blob/main/docs/product_detail.png?raw=true)

#### 2.4. Update Product

![Update Product](https://github.com/naneps/klontong/blob/main/docs/update_product.png?raw=true)

#### 2.5. Delete Product

![Delete Product](https://github.com/naneps/klontong/blob/main/docs/delete_product.png?raw=true)

#### Open Source API Integration:
The application integrates with the open-source API from **[crudcrud.com](https://crudcrud.com/)**, which provides an endpoint for performing CRUD operations (Create, Read, Update, Delete) on products. All product data is stored and retrieved through this API.

**Important Notes:**
- The **API Key** from crudcrud.com is temporary and has an expiration date. If the application encounters issues, such as being unable to add or delete products, it’s likely that the API Key has changed or **expired**.
- In such cases, please update the **API Key** with a new one from crudcrud.com.

---

## 3. Firebase Crashlytics Integration

### Overview
This application is integrated with **Firebase Crashlytics** for real-time crash reporting and error tracking. Crashlytics helps monitor app stability, providing valuable insights into crashes and non-fatal errors, allowing for faster identification and resolution of issues.

### Features
- **Crash Reporting**: Automatically logs crashes with detailed stack traces, helping identify the root cause of unexpected failures.
- **Error Tracking**: Captures non-fatal errors and exceptions, including custom error logs, to provide a comprehensive view of app health.
- **Real-time Updates**: Delivers real-time reports on issues, enabling quick responses to emerging problems.

![CRASHLYTICS](https://github.com/naneps/klontong/blob/main/docs/crashlytics.png?raw=true)

---
