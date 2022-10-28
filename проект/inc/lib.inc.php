<?php
function clearStr($data) {
    return trim(strip_tags($data));
}

function clearInt($data) {
    return abs((int)$data);
}

function getURLWithNewGetParametr($name, $value)
{
    $params = array_merge($_GET, array($name => $value));
    $newQueryString = http_build_query($params);
    return (empty($_SERVER['HTTPS']) ? 'http://' : 'https://') .
    $_SERVER['HTTP_HOST'] .
    strtok($_SERVER['REQUEST_URI'], '?') . '?' . $newQueryString;
}

function getCategoriesWithQuantity($pdo)
{
    $sql = 'SELECT c.id, c.title, COUNT(*) AS quantity
            FROM product p
            LEFT JOIN category_product cp ON cp.id_product=p.id
            JOIN category c ON c.id=p.id_main_category OR c.id=cp.id_category
            WHERE p.active = 1
            GROUP BY c.id
            ORDER BY quantity DESC';
    $stmt = $pdo->query($sql);
    $categories = $stmt->fetchAll();
    return $categories;
}

function getCategoryInfoByID($pdo, $id)
{
    $sql = 'SELECT c.title, c.description, COUNT(DISTINCT p.id) AS total_active
            FROM category c
            LEFT JOIN category_product cp ON cp.id_category=c.id
            LEFT JOIN product p ON (p.id_main_category=c.id OR p.id=cp.id_product) AND p.active = 1
            WHERE c.id = ?
            GROUP BY c.id';
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$id]);
    $category = $stmt->fetch();
    return $category;
}

function getInfoAboutProducts($pdo, $cid, $productsPerPage, $offset)
{
    $sql = "SELECT p.id, p.title, p.id_main_category,
            c.title AS title_main_category, i.src, i.alt
            FROM product p
            LEFT JOIN category_product cp ON cp.id_product=p.id
            LEFT JOIN category c ON c.id=p.id_main_category
            JOIN image i ON i.id=p.id_announcement_image
            WHERE ? IN (cp.id_category, p.id_main_category) AND p.active = 1
            ORDER BY p.title
            LIMIT $productsPerPage
            OFFSET $offset";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$cid]);
    $products = $stmt->fetchAll();
    return $products;
}

function getNormalPrice($price)
{
    return $price - floor($price) ? $price : (int) $price;
}

function getFullInfoAboutProduct($pdo, $id)
{
    $sql = "SELECT p.id, p.title, p.price,
            p.price_without_discount, p.price_promocode, p.description,
            p.active, p.id_main_category, c.title AS title_main_category
            FROM product p
            JOIN category c ON c.id=p.id_main_category
            WHERE p.id=?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$id]);
    if (!$product = $stmt->fetch()) {
        return false;
    }

    $sql = "SELECT c.id, c.title FROM product p
            JOIN category_product cp ON cp.id_product=p.id
            JOIN category c ON c.id=cp.id_category
            WHERE p.id=?
            ORDER BY c.title";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$id]);
    $product['categories'] = [];
    while ($row = $stmt->fetch()) {
        $product['categories'][$row['id']] = $row['title'];
    }

    $sql = "SELECT i.src, i.alt FROM image i
            JOIN product_image pi ON pi.id_image=i.id
            JOIN product p ON p.id=pi.id_product
            WHERE p.id=?
            ORDER BY i.src";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$id]);
    $product['images'] = $stmt->fetchAll();

    $product['price'] = getNormalPrice($product['price']);
    $product['price_without_discount'] = getNormalPrice($product['price_without_discount']);
    $product['price_promocode'] = getNormalPrice($product['price_promocode']);

    return $product;
}

function sendFeedback($pdo, $name, $email, $birthyear, $sex, $subject, $question)
{
    $sql = 'INSERT INTO feedback (name, email, birthyear, sex, subject, question)
            VALUES (:name, :email, :birthyear, :sex, :subject, :question)';
    $stmt = $pdo->prepare($sql);
    return $stmt->execute([
        'name' => $name, 'email' => $email,
        'birthyear' => $birthyear, 'sex' => $sex,
        'subject' => $subject, 'question' => $question,
    ]);
}
