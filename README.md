# Unsplash photo collection
### Test task from White and fluffy (06-2022)
Mostly it was complete without any knowledge of... network, API, libraries, patterns ))

---

**Task (rus):**

_Стартовый экран — таббар с двумя вкладками.  
На ***первой вкладке*** — коллекция случайных фотографий с Unsplash.
Вверху строка поиска по фотографиям с Unsplash. При нажатии на ячейку
пользователь попадает на экран подробной информации.  
На ***второй вкладке*** — таблица со списком любимых фотографий,
в ячейке миниатюрка фотографии и имя автора.
При нажатии на ячейку — переход в экран подробной информации._

_Экран подробной информации содержит в себе фотографию, имя автора,
дату создания, местоположение и количество скачиваний.  
Также экран содержит кнопку, нажатие на которую может добавить фотографию
в список любимых фотографий и удалить из него.  
При желании можно сделать этот список редактируемым.  
Ссылка на API - https://unsplash.com/documentation_

_1. Всю вёрстку приложения делайте кодом, без xib и storyboard._  
_2. Не используйте SnapKit, верстать нужно только через Auto Layout._  
_3. Не используйте SwiftUI._  
_4. Используйте как минимум одну стороннюю библиотеку Cocoa Pods.  
(кроме Unsplash Photo Picker for iOS и прочие подобные для работы с Unsplash)._  
_5. Должен быть как минимум один алерт._  
_6. На задачу должно уйти до 16 часов (2 рабочих дня)._ 

---

**Unrealised features and bad things:**
* photos are not displayed randomly;  
* endlessly add the same photo to favorites;  
* non-contextual naming;  
* some problems with codestyle;  
* controllers are overloaded with UI logic;  
* screen with additional information is better placed in a separate controller;  
* The network layer (NetworkDataFetcher) should be created once for the entire application, it is better to close the service with a Singleton.
