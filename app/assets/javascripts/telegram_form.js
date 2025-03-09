document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("form-submit");

  form.addEventListener("submit", function (event) {
    event.preventDefault(); // Останавливаем стандартную отправку формы

    // Инициализируем WebApp
    let tg = window.Telegram.WebApp;
    tg.ready();

    // Создаем FormData для формы
    const formData = new FormData(form);

    // Добавляем initData в FormData
    formData.append("user_telegram_id", tg.initDataUnsafe?.user?.id);
    formData.append("username", tg.initDataUnsafe?.user?.username);
    formData.append("first_name", tg.initDataUnsafe?.user?.first_name);
    formData.append("last_name", tg.initDataUnsafe?.user?.last_name);

    // Отправляем форму с дополнительными данными через fetch
    fetch(form.action, {
      method: form.method,
      body: formData,
    })
      .then((response) => {
        if (response.ok) {
          // Скрываем форму и показываем сообщение
          tg.close()
        } else {
          document.getElementById("form-container").style.display = "none";
          document.getElementById("response-message-failure").style.display =
            "block";
        }
      })
      .catch((error) => {
        alert("Ошибка при отправке формы. Попробуйте снова");
      });
  });
});
