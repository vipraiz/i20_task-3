<?php
require_once 'inc/config.inc.php';
require_once 'inc/lib.inc.php';

$title = '';
if (!isset($_GET['cat_id'])) {
    $title = 'Категории товаров';
    $categories = getCategoriesWithQuantity($pdo);
    if (!count($categories)) {
        echo '<a class="regular-link" href="products.php">Назад</a>';
        echo '<div>Упс! Все товары закончились</div>';
        exit;
    }
} else {
    $id = $_GET['cat_id'];
    list(
        'title' => $title,
        'description' => $descriprion,
        'total_active' => $totalActiveProducts
    ) = getCategoryInfoByID($pdo, $id);
    if (!$title) {
        include 'inc/redirect404.inc.php';
    }

    $totalPages = (int) ceil($totalActiveProducts / $productsPerPage);
    $page = 1;
    if (isset($_GET['page'])) {
        $page = $_GET['page'];
        if ($page > $totalPages) {
            header("Location: products.php?cat_id=$id");
            exit;
        }
    }
    $offset = $productsPerPage * ($page - 1);
    $products = getInfoAboutProducts($pdo, $id, $productsPerPage, $offset);
}
?>

<!DOCTYPE html>
<html lang="ru">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="author" content="Тапхаров Вадим">
  <title><?=$title?></title>
  <link rel="stylesheet" href="css/vendor/normalize.css">
  <link rel="stylesheet" href="css/style.css">
</head>

<body>
  <main>
    <div class="layout">
<?php
if ($id) {
    echo '<a class="regular-link" href="products.php">Назад</a>';
}
?>
      <section class="products">
        <h1 class="products__title"><?=$title?></h1>
<?php
if (!$id) {
    echo '<div class="categories">';
    foreach ($categories as $category) {
        ?>
        <a class="categories__link" href="?cat_id=<?=$category['id']?>">
          <div class="categories__item">
            <div class="categories__item-title"><?=$category['title']?></div>
            <div class="categories__item-quantity">
              Количество товаров: <span><?=$category['quantity']?></span>
            </div>
          </div>
        </a>
<?php
}
    echo '</div>';
} else {
    ?>
        <div class="category-descr">
          <?=$descriprion?>
        </div>
<?php
if (!$totalActiveProducts) {
        echo '<div>Нет доступных товаров данной категории</div>';
        exit;
    }
    echo '<div class="products__items">';
    foreach ($products as $product) {
        ?>
        <div class="products__item">
          <div class="products__image">
            <img src="images/products/<?=$product['src']?>" alt="<?=$product['alt']?>">
          </div>
          <div class="products__info">
            <a href="product.php?id=<?=$product['id']?>" class="products__link"
              aria-label="Перейти на страницу товара <?=$product['title']?>"></a>
            <div class="products__item-title">
              <?=$product['title']?>
            </div>
            <div class="products__main-category">
              Основная категория:
              <a href="?cat_id=<?=$product['id_main_category']?>" class="regular-link">
                <?=$product['title_main_category']?>
              </a>
            </div>
          </div>
        </div>
<?php
}
    echo '</div>';
}
if ($id && $totalPages > 1) {
    ?>
        <nav class="pagination">
          <a class="<?=$page == 1 ? ' disabled-link' : 'regular-link'?>"
            href="<?=getURLWithNewGetParametr('page', 1)?>">В начало</a>
<?php
if ($page > 1) {
        ?>
          <a class="regular-link"
            href="<?=getURLWithNewGetParametr('page', $page - 1)?>">Предыдушая страница</a>
<?php
}
    ?>
<?php
if ($page < $totalPages) {
        ?>
          <a class="regular-link"
            href="<?=getURLWithNewGetParametr('page', $page + 1)?>">Следующая страница</a>
<?php
}
    ?>
          <a class="<?=$page == $totalPages ? ' disabled-link' : 'regular-link'?>"
            href="<?=getURLWithNewGetParametr('page', $totalPages)?>">В конец</a>
        </nav>
<?php
}
?>
      </section>
      <div class="feedback">
        <a href="feedback.php" class="regular-link feedback-link">Обратная связь</a>
      </div>
    </div>
  </main>
</body>