<?php
require_once 'inc/config.inc.php';
require_once 'inc/lib.inc.php';

if (!isset($_GET['id'])) {
    include 'inc/redirect404.inc.php';
} else {
    $id = $_GET['id'];
    $product = getFullInfoAboutProduct($pdo, $id);
    if (!$product) {
        include 'inc/redirect404.inc.php';
    }

    $breadcrumbCategoryID = $product['id_main_category'];
    $breadcrumbCategoryTitle = $product['title_main_category'];
    if ((empty($_SERVER['HTTPS']) ? 'http://' : 'https://')
        . $_SERVER['HTTP_HOST'] == stristr($_SERVER['HTTP_REFERER'], '/products.php?', true)) {
        preg_match('/(?<=cat_id=)(?:\d+)/', $_SERVER['HTTP_REFERER'], $match);
        if ($match[0] != $product['id_main_category']
            && array_key_exists($match[0], $product['categories'])) {
            $breadcrumbCategoryID = $match[0];
            $breadcrumbCategoryTitle = $product['categories'][$match[0]];
        }
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
  <title><?=$product['title']?></title>
  <link rel="stylesheet" href="css/vendor/normalize.css">
  <link rel="stylesheet" href="css/vendor/toastr.min.css">
  <link rel="stylesheet" href="css/style.css">
</head>

<body>
  <main>
    <div class="layout">
      <div class="breadcrumbs">
        <span class="breadcrumbs__item">
          <a class="regular-link" href="products.php">Категории</a>
        </span>
        <span class="breadcrumbs__item">
          <a class="regular-link" href="products.php?cat_id=<?=$breadcrumbCategoryID?>"><?=$breadcrumbCategoryTitle?></a>
        </span>
        <span class="breadcrumbs__item">
          <span class="current"><?=$product['title']?></span>
        </span>
      </div>
      <section class="product">
        <div class="product__slider">
          <div class="product__preview">
            <div class="product__preview-slides">
<?php
foreach ($product['images'] as $image) {
    echo "<img src=\"images/products/{$image['src']}\" alt=\"{$image['alt']}\" width=\"90\" height=\"130\">";
}
?>
            </div>
            <button class="product__preview-btn display-none" type="button" aria-label="показать следующее фото">
              <img src="images/icons/arrow-down.png" alt="down" aria-hidden="true">
            </button>
          </div>
          <div class="product__main-image">
<?php
foreach ($product['images'] as $image) {
    echo "<img src=\"images/products/{$image['src']}\" alt=\"{$image['alt']}\" width=\"340\" height=\"492\">";
}
?>
          </div>
        </div>
        <div class="product__description">
          <h2 class="product__title"><?=$product['title']?></h2>
          <div class="product__wrapper">
            <div class="product__categories">
              <a href="products.php?cat_id=<?=$product['id_main_category']?>" class="hover-underline">
                <?=$product['title_main_category']?>
              </a>
<?php
foreach ($product['categories'] as $id => $title) {
    echo "<a href=\"products.php?cat_id=$id\" class=\"hover-underline\">$title</a>";
}
?>
            </div>
            <div class="product__price-info">
              <div class="product__price-regular">
                <span class="product__price product__price--old"><?=$product['price_without_discount']?></span>
                <span class="product__price product__price--lowlight price-currency"><?=$product['price']?></span>
              </div>
              <div class="product__price-discount">
                <span class="product__price price-currency"><?=$product['price_promocode']?></span>
                — с промокодом
              </div>
            </div>
            <div class="product__info">
<?php
if ($product['active']) {
    ?>
              <div class="product__info-item">
                <img src="images/icons/marker-check.png" alt="*" aria-hidden="true" width="17" height="13">
                <span>
                  В наличии в магазине
                  <a href="#" class="hover-underline">Lamoda</a>
                </span>
              </div>
<?php
}
?>
              <div class="product__info-item">
                <img src="images/icons/marker-delivery.png" alt="*" aria-hidden="true" width="17" height="13">
                Бесплатная доставка
              </div>
            </div>
          </div>
          <div class="product__control">
<?php
if (!$product['active']) {
    echo "Товар в данный момент не доступен";
} else {
    ?>
            <div class="product__control-item">
              <label for="product-quantity">Количество товара: </label>
              <div class="number-input">
                <button class="inactive" aria-label="Увеличить счётчик товаров"
                  onclick="this.nextElementSibling.stepDown()"></button>
                <input type="number" id="product-quantity" min="1" max="9999" step="1" value="1">
                <button aria-label="Уменьшить счётчик товаров" onclick="this.previousElementSibling.stepUp()"></button>
              </div>
            </div>
            <div class="product__actions">
              <button id="buy-btn" class="btn custom-btn--blue" type="button">купить</button>
              <button class="btn" type="button">в избранное</button>
            </div>
<?php
}
?>
          </div>
          <div class="product__text">
            <p><?=$product['description']?></p>
          </div>
          <div class="product__share">
            <div class="product__share-text">Поделиться:</div>
            <div class="product__share-social">
              <div class="products__share-links">
                <a href="#" aria-label="Перейти во ВКонтакте">
                  <img src="images/icons/vk.png" alt="vk" width="30" height="30">
                </a>
                <a href="#" aria-label="Перейти в Google Plus">
                  <img src="images/icons/googlePlus.png" alt="google+" width="30" height="30">
                </a>
                <a href="#" aria-label="Перейти в Facebook">
                  <img src="images/icons/facebook.png" alt="facebook" width="30" height="30">
                </a>
                <a href="#" aria-label="Перейти в Twitter">
                  <img src="images/icons/twitter.png" alt="twitter" width="30" height="30">
                </a>
              </div>
              <div class="product__share-count">123</div>
            </div>
          </div>
        </div>
      </section>
    </div>
  </main>
  <script src="js/vendor/jquery-3.6.1.min.js"></script>
  <script src="js/vendor/toastr.min.js"></script>
  <script src="js/script.js"></script>
</body>

</html>
