# 🛒 TolykSebet — iOS Advanced Final Project

**ТолықСебет** — это современное iOS-приложение для заказа продуктов. Приложение создано с нуля с использованием SwiftUI, архитектуры MVVM, UIKit-навигации и Firebase. Поддерживаются авторизация по номеру телефона и почте, поиск товаров, добавление в корзину и оформление заказа.

---

## 📲 Features

- Авторизация через Firebase:
  - Email + пароль
  - Номер телефона + SMS-код
- Главный экран со списком продуктов и категорий
- Подробный экран продукта
- Избранное (Favorites)
- Поиск по DummyJSON API
- Корзина с возможностью увеличивать/уменьшать количество
- Оформление заказа (Checkout)
- Поддержка TabBar навигации
- Кеширование изображений и Lazy Loading
- Сохранение города доставки (UserDefaults)

---

## 🛠️ Technologies Used

| Технология           | Использование                                  |
|----------------------|-----------------------------------------------|
| **SwiftUI**          | UI и навигация                                 |
| **MVVM**             | Архитектурный паттерн                         |
| **UIKit**            | `UIHostingController` + `SceneDelegate`       |
| **FirebaseAuth**     | Email/Password и Phone Auth                   |
| **UserDefaults**     | Сохранение состояния (например, города)       |
| **Swift Concurrency**| `async/await` для работы с API                |
| **SPM**              | Подключение зависимостей (Firebase)           |

---

## 🔒 Authentication

- Email/password авторизация с валидацией
- Phone number login с кодом подтверждения (Firebase Phone Auth)
- Проверка на симуляторе с мок-верификацией

---

## 📁 Project Structure

```plaintext
TolykSebet/
├── Account/
├── Cart/
├── Checkout/
├── Explore/
├── Favorites/
├── Models/
├── ProductDetail/
├── Services/
├── StoreHome/
├── TabNavigation/
├── Authentication/
├── Utilities/
└── Resources/
