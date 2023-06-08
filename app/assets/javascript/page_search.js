window.addEventListener('load', () => {
// Получите поле для ввода
    const input = document.getElementById('myInput');

// Добавьте обработчик события, чтобы выполнить поиск при вводе текста
    if (input) {
        input.addEventListener('keyup', function (event) {
            // Получите текст из поля для ввода
            var filter = event.target.value.toUpperCase();

            // Получите все элементы списка
            var items = document.getElementById('myList').getElementsByTagName('div');

            // Переберите все элементы списка и скройте те, которые не соответствуют поиску
            for (var i = 0; i < items.length; i++) {
                var txtValue = items[i].textContent || items[i].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    items[i].style.display = "";
                } else {
                    items[i].style.display = "none";
                }
            }
        });
    }
})
