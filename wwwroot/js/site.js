// ========================================================
// TasteBite Restaurant - Custom Interactive JavaScript
// ========================================================

document.addEventListener('DOMContentLoaded', function () {
    // 1. Toast Notification Trigger Helper
    window.showToast = function (message, title = 'Cart Updated', isSuccess = true) {
        const toastEl = document.getElementById('liveAppToast');
        if (!toastEl) return;

        const titleEl = document.getElementById('toastTitle');
        const bodyEl = document.getElementById('toastMessage');
        const iconEl = document.getElementById('toastIcon');

        if (titleEl) titleEl.textContent = title;
        if (bodyEl) bodyEl.textContent = message;

        if (iconEl) {
            iconEl.className = isSuccess 
                ? 'bi bi-check-circle-fill text-success fs-5' 
                : 'bi bi-exclamation-circle-fill text-warning fs-5';
        }

        const toast = new bootstrap.Toast(toastEl, { delay: 4000 });
        toast.show();
    };

    // 2. AJAX Add to Cart Handler
    document.querySelectorAll('.ajax-add-to-cart').forEach(function (form) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();

            const formData = new FormData(form);
            const submitBtn = form.querySelector('button[type="submit"]');
            const originalBtnHtml = submitBtn ? submitBtn.innerHTML : '';

            if (submitBtn) {
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span> Adding...';
            }

            fetch(form.action, {
                method: 'POST',
                body: formData,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
            .then(response => {
                if (!response.ok) throw new Error('Network error');
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    // Update Cart badge in navbar
                    const cartBadge = document.getElementById('cartBadgeCount');
                    if (cartBadge) {
                        cartBadge.textContent = data.totalCount;
                        cartBadge.style.display = data.totalCount > 0 ? 'inline-block' : 'none';
                        cartBadge.classList.remove('cart-badge-pulse');
                        void cartBadge.offsetWidth; // trigger reflow
                        cartBadge.classList.add('cart-badge-pulse');
                    }

                    // Show success toast
                    window.showToast(data.message, 'Delicious Choice!');
                } else {
                    window.showToast(data.message || 'Could not add to cart.', 'Notice', false);
                }
            })
            .catch(err => {
                console.error(err);
                // Fallback to normal submit if ajax fails
                form.submit();
            })
            .finally(() => {
                if (submitBtn) {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = originalBtnHtml;
                }
            });
        });
    });

    // 3. Details Page & Cart Page Quantity Steppers
    document.querySelectorAll('.qty-stepper-btn').forEach(btn => {
        btn.addEventListener('click', function () {
            const isPlus = this.getAttribute('data-action') === 'increase';
            const targetId = this.getAttribute('data-target');
            const input = document.getElementById(targetId);

            if (input) {
                let currentVal = parseInt(input.value) || 1;
                const min = parseInt(input.getAttribute('min')) || 1;
                const max = parseInt(input.getAttribute('max')) || 99;

                if (isPlus) {
                    if (currentVal < max) currentVal++;
                } else {
                    if (currentVal > min) currentVal--;
                }

                input.value = currentVal;

                // Auto submit form on cart page if data-auto-submit is true
                if (input.getAttribute('data-auto-submit') === 'true') {
                    const form = input.closest('form');
                    if (form) form.submit();
                }
            }
        });
    });

    // 4. Client-side Live Search on Menu Page (instant feedback)
    const liveSearchInput = document.getElementById('menuLiveSearch');
    if (liveSearchInput) {
        liveSearchInput.addEventListener('keyup', function () {
            const query = this.value.toLowerCase().trim();
            const foodCards = document.querySelectorAll('.food-item-wrapper');
            let visibleCount = 0;

            foodCards.forEach(card => {
                const name = (card.getAttribute('data-food-name') || '').toLowerCase();
                const desc = (card.getAttribute('data-food-desc') || '').toLowerCase();
                const category = (card.getAttribute('data-food-category') || '').toLowerCase();

                if (name.includes(query) || desc.includes(query) || category.includes(query)) {
                    card.style.display = '';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });

            const noResultsEl = document.getElementById('noResultsMessage');
            if (noResultsEl) {
                noResultsEl.style.display = (visibleCount === 0) ? 'block' : 'none';
            }
        });
    }

    // 5. Checkout Payment Selection Highlighting
    const paymentOptions = document.querySelectorAll('.payment-card-option');
    paymentOptions.forEach(opt => {
        opt.addEventListener('click', function () {
            paymentOptions.forEach(o => o.classList.remove('selected'));
            this.classList.add('selected');
            const radio = this.querySelector('input[type="radio"]');
            if (radio) {
                radio.checked = true;
                toggleCardDetails(radio.value);
            }
        });
    });

    function toggleCardDetails(paymentMethod) {
        const cardDetailsSection = document.getElementById('demoCardDetailsSection');
        if (!cardDetailsSection) return;

        if (paymentMethod === 'Demo Online Payment') {
            cardDetailsSection.style.display = 'block';
        } else {
            cardDetailsSection.style.display = 'none';
        }
    }

    // Initialize payment selection on page load
    const checkedRadio = document.querySelector('.payment-card-option input[type="radio"]:checked');
    if (checkedRadio) {
        checkedRadio.closest('.payment-card-option')?.classList.add('selected');
        toggleCardDetails(checkedRadio.value);
    }
});
