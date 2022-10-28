<?php
require_once 'inc/config.inc.php';
require_once 'inc/lib.inc.php';

$successMessage = '';
if ($_GET['mes'] == 'success') {
    $successMessage = '<div class="auth-form__success-message">Данные успешно сохранены!</div>';
}

$thisYear = date('Y');
$lowestAllowableYear = $thisYear - 120;

$name = $email = $birthyear = $sex = $subject = $question = $contractIsRead = '';
if (isset($_COOKIE['name'])) {
    $name = $_COOKIE['name'];
}
if (isset($_COOKIE['email'])) {
    $email = $_COOKIE['email'];
}
if (isset($_COOKIE['birthyear'])) {
    $birthyear = $_COOKIE['birthyear'];
}
if (isset($_COOKIE['sex'])) {
    $sex = $_COOKIE['sex'];
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    function getErrorMessageBlock($errorMessage)
    {
        return "<div class=\"auth-form__error-message\">$errorMessage</div>";
    }

    function addErrorMessageIfEmpty($data, $inputName, &$errors)
    {
        $isEmpty = empty($data);
        if ($isEmpty) {
            $errors[$inputName] = getErrorMessageBlock('Поле не может быть пустым!');
        }
        return $isEmpty;
    }

    $patternName = '/^[а-яё]*$/iu';
    $patternEmail = "/^[a-z0-9!#$%&'*+\\/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+\\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/";
    // $patternYear = '/^\d{4}$/';
    $patternSex = '/^(male|female)$/';

    $name = clearStr($_POST['name']);
    $email = clearStr($_POST['email']);
    $birthyear = clearInt($_POST['birthyear']);
    $sex = $_POST['sex'];
    $subject = clearStr($_POST['subject']);
    $question = clearStr($_POST['question']);
    $contractIsRead = $_POST['contract_is_read'];

    $maxLengthName = 16;
    $maxLengthEmail = 300;
    $maxLengthSubject = 100;
    $maxLengthQuestion = 2000;

    $errors = [];
    if (!addErrorMessageIfEmpty($name, 'name', $errors)) {
        if (mb_strlen($name) > $maxLengthName) {
            $errors['name'] = getErrorMessageBlock("Количество символов не должно превышать $maxLengthName");
        } elseif (!preg_match($patternName, $name)) {
            $errors['name'] = getErrorMessageBlock('Имя должно содержать только буквы русского алфавита<br>(без пробелов и знаков препинания)');
        }
    }
    if (!addErrorMessageIfEmpty($email, 'email', $errors)) {
        if (strlen($email) > $maxLengthEmail) {
            $errors['email'] = getErrorMessageBlock("Количество символов не должно превышать $maxLengthEmail");
        } elseif (!preg_match($patternEmail, $email)) {
            $errors['email'] = getErrorMessageBlock('Введите корректный адрес эллектронной почты');
        }
    }
    if (!addErrorMessageIfEmpty($birthyear, 'birthyear', $errors)
        && ($birthyear < $lowestAllowableYear || $birthyear > $thisYear)) {
        $errors['birthyear'] = getErrorMessageBlock("Год должен быть в диапазоне [$lowestAllowableYear-$thisYear]");
    }
    if (!addErrorMessageIfEmpty($sex, 'sex', $errors)
        && !preg_match($patternSex, $sex)) {
        $errors['sex'] = getErrorMessageBlock('Пол указан неверно');
    }
    if (!addErrorMessageIfEmpty($subject, 'subject', $errors)
        && mb_strlen($subject) > $maxLengthSubject) {
        $errors['subject'] = getErrorMessageBlock("Количество символов не должно превышать $maxLengthSubject");
    }
    if (!addErrorMessageIfEmpty($question, 'question', $errors)
        && mb_strlen($question) > $maxLengthQuestion) {
        $errors['question'] = getErrorMessageBlock("Количество символов не должно превышать $maxLengthQuestion");
    }
    addErrorMessageIfEmpty($contractIsRead, 'contract_is_read', $errors);

    if (!count($errors)) {
        setcookie('name', $name, INTMAXSIZE);
        setcookie('email', $email, INTMAXSIZE);
        setcookie('birthyear', $birthyear, INTMAXSIZE);
        setcookie('sex', $sex, INTMAXSIZE);

        $sex = $sex == 'male' ? 1 : 2;
        sendFeedback($pdo, $name, $email, $birthyear, $sex, $subject, $question);

        header('Location: ' . $_SERVER['PHP_SELF'] . '?mes=success');
        exit;
    }
}
?>

<!DOCTYPE html>
<html lang="ru">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="author" content="Тапхаров Вадим">
  <title>Форма авторизации</title>
  <link rel="stylesheet" href="css/vendor/normalize.css">
  <link rel="stylesheet" href="css/style.css">
</head>

<body class="bgc-gray">
  <main>
    <div class="layout">
      <section class="authorization">
        <form class="auth-form" action="<?=$_SERVER['PHP_SELF']?>" method="post">
          <a class="regular-link" href="products.php">Назад</a>
          <h1 class="auth-form__title">ОБРАТНАЯ СВЯЗЬ</h1>
          <?=$successMessage?>
          <div class="auth-form__content">
            <div class="auth-form__groups">
              <div class="auth-form__group">
                <label class="auth-form__label" for="name">ИМЯ</label>
                <input class="auth-form__input<?=$errors['name'] ? ' auth-form__input-error' : ''?>"
                  type="text" name="name" id="name" value="<?=$name?>" required>
                <?=$errors['name']?>
              </div>
              <div class="auth-form__group">
                <label class="auth-form__label" for="email">E-MAIL</label>
                <input class="auth-form__input<?=$errors['email'] ? ' auth-form__input-error' : ''?>"
                  type="email" name="email" id="email" value="<?=$email?>" required>
                <?=$errors['email']?>
              </div>
              <div class="auth-form__group">
                <label class="auth-form__label" for="birthyear">ГОД РОЖДЕНИЯ:</label>
                <select class="auth-form__select<?=$errors['birthyear'] ? ' auth-form__input-error' : ''?>"
                  name="birthyear" id="birthyear" required>
                  <option value="" hidden>год</option>
<?php for ($year = $thisYear; $year >= $lowestAllowableYear; $year--): ?>
	                <option value="<?=$year?>" <?=$year == $birthyear ? 'selected' : ''?>>
                    <?=$year?>
                  </option>
<?php endfor;?>
                </select>
                <?=$errors['birthyear']?>
              </div>
              <div class="auth-form__group">
                ПОЛ:
                <input class="auth-form__input-radio" type="radio" name="sex" id="radio-male"
                  value="male" required <?=$sex == 'male' ? 'checked' : ''?>>
                <label class="auth-form__label" for="radio-male">МУЖСКОЙ</label>
                <input class="auth-form__input-radio" type="radio" name="sex" id="radio-female"
                  value="female" required  <?=$sex == 'female' ? 'checked' : ''?>>
                <label class="auth-form__label" for="radio-female">ЖЕНСКИЙ</label>
                <?=$errors['sex']?>
              </div>
              <div class="auth-form__group">
                <label class="auth-form__label" for="subject">ТЕМА ОБРАЩЕНИЯ</label>
                <input class="auth-form__input<?=$errors['subject'] ? ' auth-form__input-error' : ''?>"
                  type="text" name="subject" id="subject" value="<?=$subject?>" required>
                <?=$errors['subject']?>
              </div>
              <div class="auth-form__group">
                <label class="auth-form__label" for="question">СУТЬ ВОПРОСА</label>
                <textarea class="auth-form__textarea<?=$errors['question'] ? ' auth-form__input-error' : ''?>"
                  name="question" id="question" rows="8" cols="55" required><?=$question?></textarea>
                <?=$errors['question']?>
              </div>
            </div>
            <div class="auth-form__extra">
              <div class="auth-form__checkbox-wrapper">
                <input class="auth-form__checkbox<?=$errors['contract_is_read'] ? ' auth-form__input-error' : ''?>"
                  type="checkbox" name="contract_is_read" id="contract_is_read" required
                  <?=$contractIsRead ? 'checked' : ''?>>
                <label class="auth-form__label-dim" for="contract_is_read">С контрактом ознакомлен</label>
              </div>
              <?=$errors['contract_is_read']?>
            </div>
          </div>
          <div class="auth-form__bottom">
            <input class="auth-form__btn" type="submit" value="Отправить">
          </div>
        </form>
      </section>
    </div>
  </main>
</body>

</html>