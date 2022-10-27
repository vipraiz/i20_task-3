toastr.options = {
  closeButton: true,
  debug: false,
  newestOnTop: false,
  progressBar: false,
  positionClass: 'toast-bottom-right',
  preventDuplicates: false,
  onclick: null,
  showDuration: '300',
  hideDuration: '1000',
  timeOut: '5000',
  extendedTimeOut: '1000',
  showEasing: 'swing',
  hideEasing: 'linear',
  showMethod: 'fadeIn',
  hideMethod: 'fadeOut',
};

document.querySelectorAll('.product__price').forEach((el) => {
  el.textContent = parseFloat(el.textContent).toLocaleString();
});

const productQuantityInput = document.querySelector('#product-quantity');
const buyBtn = document.querySelector('#buy-btn');
const slides = Array.from(document.querySelector('.product__preview-slides').children);
const mainPictures = Array.from(document.querySelector('.product__main-image').children);
let activeSlideIndex = 0;

if (slides.length >= 3) {
  document.querySelector('.product__preview-btn').classList.remove('display-none');
}
mainPictures[0].classList.add('display-inline');

slides.forEach((img, index) => {
  if (index >= 3) {
    img.classList.add('display-none');
  }
  img.addEventListener('mouseenter', () => {
    if (activeSlideIndex == index) return;

    mainPictures[activeSlideIndex].classList.remove('display-inline');
    mainPictures[index].classList.add('display-inline');
    activeSlideIndex = index;
  });
});

document.querySelectorAll('.number-input button').forEach((button) => {
  const input = button.parentNode.querySelector('input[type=number]');
  button.addEventListener('click', () => {
    input.dispatchEvent(new Event('change'));
  });
});

document.querySelectorAll('.number-input input[type=number]').forEach((input) => {
  function controlButtons() {
    const prevBtn = input.previousElementSibling;
    const nextBtn = input.nextElementSibling;

    if (input.value <= input.min) {
      prevBtn.classList.add('inactive');
      nextBtn.classList.remove('inactive');
    } else if (input.value >= input.max) {
      nextBtn.classList.add('inactive');
      prevBtn.classList.remove('inactive');
    } else {
      prevBtn.classList.remove('inactive');
      nextBtn.classList.remove('inactive');
    }
  }
  controlButtons();

  input.addEventListener('change', () => {
    input.value = Math.max(input.min, Math.min(input.max, input.value));
    controlButtons();
  });
});

function num_word(value, words) {
  value %= 100;
  let lastDigit = value % 10;
  if (value > 10 && value < 20) return words[2];
  if (lastDigit > 1 && lastDigit < 5) return words[1];
  if (lastDigit == 1) return words[0];
  return words[2];
}

function getMessage(value) {
  return (
    `В корзину ${value % 10 == 1 && value % 100 != 11 ? 'добавлен' : 'добавлено'} ` +
    value +
    ' ' +
    num_word(value, ['товар', 'товара', 'товаров'])
  );
}

buyBtn.addEventListener('click', () => {
  const value = parseInt(productQuantityInput.value);
  if (!value || value <= 0) {
    toastr.error('Укажите количество товаров');
    return;
  }
  toastr.success(getMessage(value));
});

productQuantityInput.addEventListener('input', () => {
  productQuantityInput.value = productQuantityInput.value.replace(/[^0-9]/g, '');
});
