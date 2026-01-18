// ===== Category Data =====
const categories = {
    pertanian: {
        name: 'Pertanian',
        icon: '🌾',
        subcategories: [
            { id: 'semua-pertanian', name: 'Semua', icon: '📦' },
            { id: 'fungisida', name: 'Fungisida', icon: '🍄' },
            { id: 'insektisida', name: 'Insektisida', icon: '🦗' },
            { id: 'herbisida', name: 'Herbisida', icon: '🌿' },
            { id: 'pupuk-organik', name: 'Pupuk Organik', icon: '🌱' },
            { id: 'pupuk-kimia', name: 'Pupuk Kimia', icon: '⚗️' },
            { id: 'bibit-tanaman', name: 'Bibit Tanaman', icon: '🌾' },
            { id: 'benih', name: 'Benih', icon: '🫘' },
            { id: 'mesin-pertanian', name: 'Mesin Pertanian', icon: '🚜' },
            { id: 'alat-pertanian', name: 'Alat Pertanian', icon: '🔧' },
            { id: 'zpt', name: 'ZPT (Zat Pengatur Tumbuh)', icon: '🧪' },
            { id: 'rodentisida', name: 'Rodentisida', icon: '🐀' },
            { id: 'molluskisida', name: 'Molluskisida', icon: '🐌' },
            { id: 'mulsa-plastik', name: 'Mulsa & Plastik', icon: '📦' },
            { id: 'irigasi', name: 'Perlengkapan Irigasi', icon: '💧' }
        ]
    },
    peternakan: {
        name: 'Peternakan',
        icon: '🐄',
        subcategories: [
            { id: 'semua-peternakan', name: 'Semua', icon: '📦' },
            { id: 'pakan-ayam', name: 'Pakan Ayam', icon: '🐔' },
            { id: 'pakan-sapi', name: 'Pakan Sapi', icon: '🐄' },
            { id: 'pakan-kambing', name: 'Pakan Kambing', icon: '🐐' },
            { id: 'pakan-ikan', name: 'Pakan Ikan', icon: '🐟' },
            { id: 'pakan-burung', name: 'Pakan Burung', icon: '🐦' },
            { id: 'obat-ternak', name: 'Obat Ternak', icon: '💊' },
            { id: 'vitamin-suplemen', name: 'Vitamin & Suplemen', icon: '💉' },
            { id: 'vaksin', name: 'Vaksin', icon: '🩺' },
            { id: 'peralatan-kandang', name: 'Peralatan Kandang', icon: '🏠' },
            { id: 'tempat-pakan', name: 'Tempat Pakan/Minum', icon: '🥣' },
            { id: 'mesin-peternakan', name: 'Mesin Peternakan', icon: '⚙️' },
            { id: 'bibit-ternak', name: 'Bibit Ternak', icon: '🐣' },
            { id: 'peralatan-kesehatan', name: 'Peralatan Kesehatan', icon: '🏥' },
            { id: 'desinfektan', name: 'Desinfektan', icon: '🧴' },
            { id: 'incubator', name: 'Incubator & Penetasan', icon: '🥚' }
        ]
    }
};

// ===== Sample Data =====
let products = [
    // PERTANIAN
    {
        id: 1,
        name: "Benih Padi Ciherang Super",
        mainCategory: "pertanian",
        subCategory: "benih",
        priceRetail: 75000,
        priceWholesale: 65000,
        pricePurchase: 55000,
        stock: 200,
        image: null,
        description: "Benih padi varietas Ciherang unggulan. Hasil panen tinggi, tahan wereng, dan cocok untuk berbagai kondisi lahan."
    },
    {
        id: 2,
        name: "Pupuk NPK Phonska 15-15-15",
        mainCategory: "pertanian",
        subCategory: "pupuk-kimia",
        priceRetail: 285000,
        priceWholesale: 270000,
        pricePurchase: 250000,
        stock: 150,
        image: null,
        description: "Pupuk NPK majemuk untuk meningkatkan kesuburan tanah dan produktivitas tanaman. Kemasan 50kg."
    },
    {
        id: 3,
        name: "Insektisida Decis 25 EC",
        mainCategory: "pertanian",
        subCategory: "insektisida",
        priceRetail: 125000,
        priceWholesale: 115000,
        pricePurchase: 100000,
        stock: 45,
        image: null,
        description: "Insektisida sistemik untuk mengendalikan hama wereng, ulat, dan serangga pengganggu tanaman."
    },
    {
        id: 4,
        name: "Herbisida Roundup 486 SL",
        mainCategory: "pertanian",
        subCategory: "herbisida",
        priceRetail: 95000,
        priceWholesale: 88000,
        pricePurchase: 75000,
        stock: 60,
        image: null,
        description: "Herbisida kontak dan sistemik untuk memberantas gulma. Efektif untuk berbagai jenis rumput liar."
    },
    {
        id: 5,
        name: "Fungisida Dithane M-45",
        mainCategory: "pertanian",
        subCategory: "fungisida",
        priceRetail: 85000,
        priceWholesale: 78000,
        pricePurchase: 65000,
        stock: 55,
        image: null,
        description: "Fungisida untuk mencegah dan mengendalikan penyakit jamur pada tanaman padi, sayuran, dan buah."
    },
    {
        id: 6,
        name: "Traktor Tangan Kubota RD 85",
        mainCategory: "pertanian",
        subCategory: "mesin-pertanian",
        priceRetail: 45000000,
        priceWholesale: 43500000,
        pricePurchase: 41000000,
        stock: 3,
        image: null,
        description: "Traktor tangan diesel 8.5 HP. Cocok untuk mengolah lahan sawah dan tegalan dengan efisien."
    },
    {
        id: 7,
        name: "Cangkul Baja Anti Karat",
        mainCategory: "pertanian",
        subCategory: "alat-pertanian",
        priceRetail: 85000,
        priceWholesale: 75000,
        pricePurchase: 60000,
        stock: 100,
        image: null,
        description: "Cangkul berkualitas tinggi dengan mata baja anti karat. Gagang kayu jati yang kuat dan nyaman."
    },
    {
        id: 8,
        name: "Pupuk Kandang Organik 25kg",
        mainCategory: "pertanian",
        subCategory: "pupuk-organik",
        priceRetail: 45000,
        priceWholesale: 38000,
        pricePurchase: 30000,
        stock: 80,
        image: null,
        description: "Pupuk kandang organik murni dari kotoran sapi. Kaya nutrisi untuk kesuburan tanah."
    },
    {
        id: 9,
        name: "Bibit Cabai Rawit TM 999",
        mainCategory: "pertanian",
        subCategory: "bibit-tanaman",
        priceRetail: 35000,
        priceWholesale: 30000,
        pricePurchase: 22000,
        stock: 90,
        image: null,
        description: "Bibit cabai rawit unggul, produktivitas tinggi, tahan penyakit. Isi 100 biji."
    },
    {
        id: 10,
        name: "Mulsa Plastik Hitam Perak",
        mainCategory: "pertanian",
        subCategory: "mulsa-plastik",
        priceRetail: 450000,
        priceWholesale: 420000,
        pricePurchase: 380000,
        stock: 25,
        image: null,
        description: "Mulsa plastik hitam perak untuk menekan gulma dan menjaga kelembaban tanah. Lebar 120cm, panjang 500m."
    },

    // PETERNAKAN
    {
        id: 11,
        name: "Pakan Ayam Broiler BR-1",
        mainCategory: "peternakan",
        subCategory: "pakan-ayam",
        priceRetail: 385000,
        priceWholesale: 365000,
        pricePurchase: 340000,
        stock: 120,
        image: null,
        description: "Pakan ayam broiler fase starter. Nutrisi lengkap untuk pertumbuhan optimal. Kemasan 50kg."
    },
    {
        id: 12,
        name: "Konsentrat Sapi Potong",
        mainCategory: "peternakan",
        subCategory: "pakan-sapi",
        priceRetail: 245000,
        priceWholesale: 230000,
        pricePurchase: 210000,
        stock: 80,
        image: null,
        description: "Konsentrat sapi potong berkualitas tinggi untuk penggemukan. Kemasan 50kg."
    },
    {
        id: 13,
        name: "Pakan Kambing Super",
        mainCategory: "peternakan",
        subCategory: "pakan-kambing",
        priceRetail: 185000,
        priceWholesale: 170000,
        pricePurchase: 155000,
        stock: 65,
        image: null,
        description: "Pakan kambing lengkap dengan nutrisi seimbang. Kemasan 25kg."
    },
    {
        id: 14,
        name: "Pelet Ikan Lele Hi-Pro",
        mainCategory: "peternakan",
        subCategory: "pakan-ikan",
        priceRetail: 165000,
        priceWholesale: 150000,
        pricePurchase: 135000,
        stock: 150,
        image: null,
        description: "Pakan ikan lele dengan protein tinggi untuk pertumbuhan cepat. Kemasan 30kg."
    },
    {
        id: 15,
        name: "Obat Cacing Ternak",
        mainCategory: "peternakan",
        subCategory: "obat-ternak",
        priceRetail: 45000,
        priceWholesale: 38000,
        pricePurchase: 30000,
        stock: 75,
        image: null,
        description: "Obat cacing untuk sapi, kambing, dan domba. Efektif membasmi cacing dalam saluran pencernaan."
    },
    {
        id: 16,
        name: "Vitamin B-Complex Unggas",
        mainCategory: "peternakan",
        subCategory: "vitamin-suplemen",
        priceRetail: 55000,
        priceWholesale: 48000,
        pricePurchase: 40000,
        stock: 90,
        image: null,
        description: "Vitamin B-Complex untuk meningkatkan nafsu makan dan stamina unggas. Kemasan 100ml."
    },
    {
        id: 17,
        name: "Vaksin ND-IB Ayam",
        mainCategory: "peternakan",
        subCategory: "vaksin",
        priceRetail: 125000,
        priceWholesale: 110000,
        pricePurchase: 95000,
        stock: 40,
        image: null,
        description: "Vaksin Newcastle Disease dan Infectious Bronchitis untuk ayam. Isi 1000 dosis."
    },
    {
        id: 18,
        name: "Tempat Minum Ayam Otomatis",
        mainCategory: "peternakan",
        subCategory: "tempat-pakan",
        priceRetail: 35000,
        priceWholesale: 28000,
        pricePurchase: 22000,
        stock: 150,
        image: null,
        description: "Tempat minum ayam otomatis kapasitas 3 liter. Mudah diisi dan dibersihkan."
    },
    {
        id: 19,
        name: "Kandang Ayam Petelur Baterai",
        mainCategory: "peternakan",
        subCategory: "peralatan-kandang",
        priceRetail: 850000,
        priceWholesale: 780000,
        pricePurchase: 650000,
        stock: 25,
        image: null,
        description: "Kandang baterai untuk 12 ekor ayam petelur. Bahan galvanis anti karat, dilengkapi tempat telur."
    },
    {
        id: 20,
        name: "Mesin Penetas Telur 100 Butir",
        mainCategory: "peternakan",
        subCategory: "incubator",
        priceRetail: 2500000,
        priceWholesale: 2300000,
        pricePurchase: 2000000,
        stock: 8,
        image: null,
        description: "Mesin penetas telur otomatis kapasitas 100 butir. Dilengkapi pengatur suhu dan kelembaban digital."
    }
];

let currentMainCategory = 'all';
let currentSubCategory = null;
let editingProduct = null;
let stockValue = 0;
let selectedMainCategory = 'pertanian';
let selectedSubCategory = 'fungisida';

// ===== Initialize App =====
document.addEventListener('DOMContentLoaded', () => {
    // Show splash screen for 2 seconds
    setTimeout(() => {
        document.getElementById('splash-screen').classList.add('fade-out');
        document.getElementById('app').classList.remove('hidden');
        renderProducts();
    }, 2000);
});

// ===== Main Category Selection =====
function selectMainCategory(category) {
    currentMainCategory = category;
    currentSubCategory = null;

    // Update active tab
    document.querySelectorAll('.main-tab').forEach(tab => {
        tab.classList.toggle('active', tab.dataset.main === category);
    });

    // Show/hide subcategory wrapper
    const subWrapper = document.getElementById('subcategory-wrapper');
    if (category === 'all') {
        subWrapper.classList.add('hidden');
    } else {
        subWrapper.classList.remove('hidden');
        renderSubcategoryFilter(category);
    }

    renderProducts();
}

// ===== Scroll Subcategories =====
function scrollSubcategories(direction) {
    const container = document.getElementById('subcategory-filter');
    const scrollAmount = 200;
    if (direction === 'left') {
        container.scrollBy({ left: -scrollAmount, behavior: 'smooth' });
    } else {
        container.scrollBy({ left: scrollAmount, behavior: 'smooth' });
    }
}

// ===== Render Subcategory Filter =====
function renderSubcategoryFilter(mainCategory) {
    const container = document.getElementById('subcategory-filter');
    const subs = categories[mainCategory].subcategories;

    // Render subcategory chips + Add button
    container.innerHTML = subs.map((sub, index) => `
        <button class="sub-chip ${index === 0 ? 'active' : ''}" 
                data-sub="${sub.id}"
                oncontextmenu="handleSubcategoryRightClick(event, '${mainCategory}', '${sub.id}')"
                onclick="selectSubCategory('${sub.id}')">
            ${sub.icon} ${sub.name}
        </button>
    `).join('') + `
        <button class="sub-chip add-btn" onclick="openAddSubcategoryModal('${mainCategory}')">
            ➕ Tambah Jenis
        </button>
    `;

    // Add tooltip hint for edit (only once)
    if (!localStorage.getItem('edit_hint_shown')) {
        const hint = document.createElement('div');
        hint.style.cssText = 'position:absolute; bottom:-25px; left:10px; font-size:10px; color:#666; font-style:italic;';
        hint.textContent = '💡 Tip: Klik kanan/tahan untuk edit';
        container.parentElement.appendChild(hint);
        setTimeout(() => hint.remove(), 5000);
        localStorage.setItem('edit_hint_shown', 'true');
    }
}

// ===== Subcategory Selection =====
function selectSubCategory(subId) {
    // Handle "Semua" option
    if (subId.startsWith('semua-')) {
        currentSubCategory = null;
    } else {
        currentSubCategory = subId;
    }

    // Update active chip
    document.querySelectorAll('.sub-chip').forEach(chip => {
        chip.classList.toggle('active', chip.dataset.sub === subId);
    });

    renderProducts();
}

// ===== Render Products =====
function renderProducts() {
    const grid = document.getElementById('product-grid');
    const emptyState = document.getElementById('empty-state');
    const searchQuery = document.getElementById('search-input')?.value?.toLowerCase() || '';

    let filteredProducts = products.filter(p => {
        // Main category filter
        if (currentMainCategory !== 'all' && p.mainCategory !== currentMainCategory) {
            return false;
        }

        // Subcategory filter
        if (currentSubCategory && p.subCategory !== currentSubCategory) {
            return false;
        }

        // Search filter
        if (searchQuery && !p.name.toLowerCase().includes(searchQuery)) {
            return false;
        }

        return true;
    });

    if (filteredProducts.length === 0) {
        grid.classList.add('hidden');
        emptyState.classList.remove('hidden');
        document.querySelector('.fab').style.display = 'flex';
    } else {
        grid.classList.remove('hidden');
        emptyState.classList.add('hidden');
        document.querySelector('.fab').style.display = 'flex';

        grid.innerHTML = filteredProducts.map(product => createProductCard(product)).join('');
    }
}

function createProductCard(product) {
    const mainCat = categories[product.mainCategory];
    const subCat = mainCat.subcategories.find(s => s.id === product.subCategory);
    const stockClass = product.stock >= 20 ? 'stock-high' : product.stock >= 5 ? 'stock-medium' : 'stock-low';

    return `
        <div class="product-card" onclick="showDetails(${product.id})">
            <div class="card-image">
                ${product.image
            ? `<img src="${product.image}" alt="${product.name}">`
            : `<span class="emoji-placeholder">${subCat?.icon || mainCat.icon}</span>`
        }
                <span class="category-badge">${subCat?.icon || ''} ${subCat?.name || mainCat.name}</span>
                <span class="stock-badge ${stockClass}">${product.stock}</span>
            </div>
            <div class="card-info">
                <div class="card-name">${product.name}</div>
                <span class="card-price">${formatPrice(product.priceRetail)}</span>
            </div>
        </div>
    `;
}

// ===== Format Price =====
function formatPrice(price) {
    if (price >= 1000000) {
        return `Rp ${(price / 1000000).toFixed(1)}jt`;
    } else if (price >= 1000) {
        return `Rp ${(price / 1000).toFixed(0)}rb`;
    }
    return `Rp ${price}`;
}

function formatPriceFull(price) {
    return 'Rp ' + price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.');
}

// ===== Search =====
function toggleSearch() {
    const searchBar = document.getElementById('search-bar');
    const searchInput = document.getElementById('search-input');

    searchBar.classList.toggle('hidden');

    if (!searchBar.classList.contains('hidden')) {
        searchInput.focus();
    } else {
        searchInput.value = '';
        renderProducts();
    }
}

function searchProducts() {
    renderProducts();
}

// ===== Form - Main Category Selection =====
function selectFormMainCategory(mainCat) {
    selectedMainCategory = mainCat;

    // Update toggle buttons
    document.querySelectorAll('.toggle-btn[data-main]').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.main === mainCat);
    });

    // Render subcategories
    renderFormSubcategories();
}

function renderFormSubcategories() {
    const container = document.getElementById('form-subcategory');
    const subs = categories[selectedMainCategory].subcategories.filter(s => !s.id.startsWith('semua-'));

    container.innerHTML = subs.map((sub, index) => `
        <button type="button" class="subcat-btn ${index === 0 || sub.id === selectedSubCategory ? 'active' : ''}" 
                data-sub="${sub.id}" 
                onclick="selectFormSubCategory('${sub.id}')">
            <span class="icon">${sub.icon}</span>
            ${sub.name}
        </button>
    `).join('');

    // Set default if not already selected
    if (!selectedSubCategory || !subs.find(s => s.id === selectedSubCategory)) {
        selectedSubCategory = subs[0].id;
    }

    // Update active state
    document.querySelectorAll('.subcat-btn').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.sub === selectedSubCategory);
    });
}

function selectFormSubCategory(subId) {
    selectedSubCategory = subId;

    document.querySelectorAll('.subcat-btn').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.sub === subId);
    });
}

// ===== Add/Edit Form =====
function openAddForm() {
    editingProduct = null;
    resetForm();

    document.getElementById('modal-title').textContent = 'Tambah Produk';
    document.getElementById('submit-icon').textContent = '+';
    document.getElementById('submit-text').textContent = 'Tambah Produk';
    document.getElementById('delete-btn').classList.add('hidden');

    // Render subcategories for form
    renderFormSubcategories();

    document.getElementById('product-modal').classList.remove('hidden');
}

function openEditForm(product) {
    editingProduct = product;

    document.getElementById('product-name').value = product.name;
    document.getElementById('product-price-retail').value = product.priceRetail;
    document.getElementById('product-price-wholesale').value = product.priceWholesale;
    document.getElementById('product-price-purchase').value = product.pricePurchase;
    document.getElementById('product-description').value = product.description || '';
    stockValue = product.stock;
    document.getElementById('stock-value').textContent = stockValue;
    selectedMainCategory = product.mainCategory;
    selectedSubCategory = product.subCategory;

    // Update main category toggle
    document.querySelectorAll('.toggle-btn[data-main]').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.main === product.mainCategory);
    });

    // Render and select subcategory
    renderFormSubcategories();

    // Update image preview if exists
    if (product.image) {
        document.getElementById('image-preview').innerHTML = `<img src="${product.image}" alt="Product">`;
    }

    document.getElementById('modal-title').textContent = 'Edit Produk';
    document.getElementById('submit-icon').textContent = '💾';
    document.getElementById('submit-text').textContent = 'Simpan Perubahan';
    document.getElementById('delete-btn').classList.remove('hidden');

    document.getElementById('product-modal').classList.remove('hidden');
}

function resetForm() {
    document.getElementById('product-form').reset();
    document.getElementById('image-preview').innerHTML = `
        <div class="image-icon">📷</div>
        <p>Ketuk untuk menambah gambar</p>
        <small>Kamera atau Galeri</small>
    `;
    stockValue = 0;
    selectedMainCategory = 'pertanian';
    selectedSubCategory = 'bibit-benih';
    document.getElementById('stock-value').textContent = '0';

    document.querySelectorAll('.toggle-btn[data-main]').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.main === 'pertanian');
    });
}

function closeModal() {
    document.getElementById('product-modal').classList.add('hidden');
    document.getElementById('details-modal').classList.add('hidden');
}

// ===== Form Controls =====
function adjustStock(delta) {
    stockValue = Math.max(0, stockValue + delta);
    document.getElementById('stock-value').textContent = stockValue;

    // Add animation
    const display = document.getElementById('stock-value');
    display.style.transform = 'scale(1.2)';
    setTimeout(() => display.style.transform = 'scale(1)', 150);
}

function pickImage() {
    document.getElementById('image-input').click();
}

function previewImage(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('image-preview').innerHTML = `<img src="${e.target.result}" alt="Product">`;
        };
        reader.readAsDataURL(file);
    }
}

// ===== Save Product =====
function saveProduct(event) {
    event.preventDefault();

    const name = document.getElementById('product-name').value;
    const priceRetail = parseFloat(document.getElementById('product-price-retail').value);
    const priceWholesale = parseFloat(document.getElementById('product-price-wholesale').value);
    const pricePurchase = parseFloat(document.getElementById('product-price-purchase').value);
    const description = document.getElementById('product-description').value;

    // Get image if exists
    const imgElement = document.querySelector('#image-preview img');
    const image = imgElement ? imgElement.src : null;

    if (editingProduct) {
        // Update existing
        const index = products.findIndex(p => p.id === editingProduct.id);
        products[index] = {
            ...products[index],
            name,
            mainCategory: selectedMainCategory,
            subCategory: selectedSubCategory,
            priceRetail,
            priceWholesale,
            pricePurchase,
            stock: stockValue,
            description,
            image: image || products[index].image
        };
        showSnackbar('Produk berhasil diperbarui');
    } else {
        // Add new
        const newProduct = {
            id: Date.now(),
            name,
            mainCategory: selectedMainCategory,
            subCategory: selectedSubCategory,
            priceRetail,
            priceWholesale,
            pricePurchase,
            stock: stockValue,
            description,
            image
        };
        products.unshift(newProduct);
        showSnackbar('Produk berhasil ditambahkan');
    }

    closeModal();
    renderProducts();
}

// ===== Delete Product =====
function deleteProduct() {
    if (editingProduct && confirm(`Apakah Anda yakin ingin menghapus "${editingProduct.name}"?`)) {
        products = products.filter(p => p.id !== editingProduct.id);
        closeModal();
        renderProducts();
        showSnackbar('Produk dihapus');
    }
}

// ===== Product Details =====
function showDetails(id) {
    const product = products.find(p => p.id === id);
    if (!product) return;

    const mainCat = categories[product.mainCategory];
    const subCat = mainCat.subcategories.find(s => s.id === product.subCategory);
    const stockClass = product.stock >= 20 ? 'high' : product.stock >= 5 ? 'medium' : 'low';
    const stockStatus = product.stock >= 20 ? 'Stok Tersedia' : product.stock >= 5 ? 'Stok Menipis' : product.stock > 0 ? 'Hampir Habis' : 'Stok Habis';

    document.getElementById('details-content').innerHTML = `
        <div class="details-image">
            ${product.image
            ? `<img src="${product.image}" alt="${product.name}">`
            : `<div class="details-image-placeholder">
                    <span class="emoji">${subCat?.icon || mainCat.icon}</span>
                    <small style="color: var(--text-secondary); margin-top: 8px;">Tidak ada gambar</small>
                   </div>`
        }
        </div>
        
        <div class="details-body">
            <div class="details-badges">
                <span class="detail-category-badge">${mainCat.icon} ${mainCat.name}</span>
                <span class="detail-subcat-badge">${subCat?.icon || ''} ${subCat?.name || ''}</span>
                <span class="detail-stock-badge ${stockClass}">📦 ${product.stock} · ${stockStatus}</span>
            </div>
            
            <h2 class="details-name">${product.name}</h2>
            
            <div class="details-price-box">
                <span class="icon">💰</span>
                <div style="width: 100%">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                        <span style="color: var(--text-secondary)">Harga Eceran:</span>
                        <span class="price-value" style="color: var(--primary-color)">${formatPriceFull(product.priceRetail)}</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                        <span style="color: var(--text-secondary)">Harga Tengkulak:</span>
                        <span class="price-value" style="font-size: 16px;">${formatPriceFull(product.priceWholesale)}</span>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span style="color: var(--text-secondary)">Harga Beli:</span>
                        <span class="price-value" style="font-size: 16px; color: #666;">${formatPriceFull(product.pricePurchase)}</span>
                    </div>
                </div>
            </div>
            
            ${product.description ? `
                <div class="details-description">
                    <h4>Deskripsi</h4>
                    <p>${product.description}</p>
                </div>
            ` : ''}
            
            <div class="details-actions">
                <button class="btn-outline" onclick="closeModal(); openEditForm(products.find(p => p.id === ${product.id}))">
                    ✏️ Edit
                </button>
                <button class="btn-danger" onclick="deleteFromDetails(${product.id})">
                    🗑️ Hapus
                </button>
            </div>
        </div>
    `;

    document.getElementById('details-modal').classList.remove('hidden');
}

function deleteFromDetails(id) {
    const product = products.find(p => p.id === id);
    if (product && confirm(`Apakah Anda yakin ingin menghapus "${product.name}"?`)) {
        products = products.filter(p => p.id !== id);
        closeModal();
        renderProducts();
        showSnackbar('Produk dihapus');
    }
}

// ===== Snackbar =====
function showSnackbar(message) {
    // Remove existing snackbar
    const existing = document.querySelector('.snackbar');
    if (existing) existing.remove();

    const snackbar = document.createElement('div');
    snackbar.className = 'snackbar';
    snackbar.textContent = message;
    document.body.appendChild(snackbar);

    setTimeout(() => snackbar.remove(), 3000);
}

// ===== Close modals on backdrop click =====
document.addEventListener('click', (e) => {
    if (e.target.classList.contains('modal')) {
        closeModal();
    }
});

// ===== Keyboard support =====
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
        closeModal();
        closeSubcategoryModal();
    }
});

// ===== Add/Edit Subcategory Modal =====
let addingToCategory = null;
let editingSubId = null; // New: Track if editing
let selectedNewIcon = '📦';

const availableIcons = [
    '📦', '🌾', '🌿', '🍄', '🦗', '🐛', '🌱', '🫘', '🚜', '🔧', '🧪', '🐀', '🐌', '💧',
    '🐔', '🐄', '🐐', '🐟', '🐦', '💊', '💉', '🩺', '🏠', '🥣', '⚙️', '🐣', '🏥', '🧴', '🥚',
    '🌻', '🌽', '🍃', '🥬', '🍅', '🥕', '🧅', '🥔', '🐷', '🐑', '🐴', '🦆', '🐰', '🦃',
    '🌲', '🪵', '🪴', '🧺', '🪣', '⛏️', '🪓', '🌡️', '💡', '🔌', '🛠️', '📏'
];

function openAddSubcategoryModal(mainCategory) {
    addingToCategory = mainCategory;
    editingSubId = null; // Reset editing state
    selectedNewIcon = '📦';
    prepareModalUI('Tambah Jenis Baru', '+', 'Tambah Jenis', true);
}

function handleSubcategoryRightClick(event, mainCategory, subId) {
    event.preventDefault(); // Prevent browser context menu
    openEditSubcategoryModal(mainCategory, subId);
}

// Touch support for long press
let touchTimer;
document.addEventListener('touchstart', (e) => {
    if (e.target.closest('.sub-chip')) {
        touchTimer = setTimeout(() => {
            // Trigger edit
        }, 800);
    }
}, { passive: true });

document.addEventListener('touchend', () => clearTimeout(touchTimer));

function openEditSubcategoryModal(mainCategory, subId) {
    addingToCategory = mainCategory;
    editingSubId = subId;

    // Find existing data
    const sub = categories[mainCategory].subcategories.find(s => s.id === subId);
    if (!sub) return;

    selectedNewIcon = sub.icon;
    document.getElementById('subcategory-name').value = sub.name;

    prepareModalUI('Edit Jenis', '💾', 'Simpan Perubahan', false);
}

function prepareModalUI(title, btnIcon, btnText, isAdd) {
    // Set category label
    const cat = categories[addingToCategory];
    document.getElementById('subcat-category-label').innerHTML = `${cat.icon} ${cat.name}`;

    // Update labels/buttons
    document.querySelector('#subcategory-modal h2').textContent = title;
    document.getElementById('subcat-submit-icon').textContent = btnIcon;
    document.getElementById('subcat-submit-text').textContent = btnText;

    // Show/Hide delete button
    const deleteBtn = document.getElementById('delete-subcat-btn');
    if (isAdd) {
        deleteBtn.classList.add('hidden');
    } else {
        deleteBtn.classList.remove('hidden');
    }

    renderIconPicker();
    selectIcon(selectedNewIcon); // Updates preview
    document.getElementById('subcategory-modal').classList.remove('hidden');
}

function closeSubcategoryModal() {
    document.getElementById('subcategory-modal').classList.add('hidden');
}

function renderIconPicker() {
    const container = document.getElementById('icon-picker');
    container.innerHTML = availableIcons.map(icon => `
        <button type="button" class="icon-btn ${icon === selectedNewIcon ? 'selected' : ''}" 
                onclick="selectIcon('${icon}')">
            ${icon}
        </button>
    `).join('');
}

function selectIcon(icon) {
    selectedNewIcon = icon;
    document.getElementById('selected-icon-preview').textContent = icon;

    document.querySelectorAll('.icon-btn').forEach(btn => {
        btn.classList.toggle('selected', btn.textContent.trim() === icon);
    });
}

function saveSubcategory(event) {
    event.preventDefault();

    const name = document.getElementById('subcategory-name').value.trim();
    if (!name) return;

    if (editingSubId) {
        // --- UPDATE EXISTING ---
        const subIndex = categories[addingToCategory].subcategories.findIndex(s => s.id === editingSubId);
        if (subIndex !== -1) {
            categories[addingToCategory].subcategories[subIndex].name = name;
            categories[addingToCategory].subcategories[subIndex].icon = selectedNewIcon;

            saveCategoriesToStorage();
            closeSubcategoryModal();
            renderSubcategoryFilter(addingToCategory);
            showSnackbar('Jenis berhasil diperbarui!');
        }
    } else {
        // --- ADD NEW ---
        const newId = name.toLowerCase().replace(/[^a-z0-9]+/g, '-');
        const existingSubs = categories[addingToCategory].subcategories;

        if (existingSubs.some(s => s.id === newId)) {
            showSnackbar('Jenis ini sudah ada!');
            return;
        }

        const newSubcategory = {
            id: newId,
            name: name,
            icon: selectedNewIcon
        };

        existingSubs.push(newSubcategory);
        saveCategoriesToStorage();
        closeSubcategoryModal();
        renderSubcategoryFilter(addingToCategory);
        showSnackbar(`Jenis "${name}" berhasil ditambahkan!`);
    }
}

function deleteSubcategory() {
    if (!editingSubId) return;

    if (confirm('Yakin ingin menghapus jenis ini? Produk dengan jenis ini mungkin akan kehilangan kategorinya.')) {
        const subs = categories[addingToCategory].subcategories;
        const newSubs = subs.filter(s => s.id !== editingSubId);
        categories[addingToCategory].subcategories = newSubs;

        saveCategoriesToStorage();
        closeSubcategoryModal();

        // Refresh filter and products
        currentSubCategory = null;
        renderSubcategoryFilter(addingToCategory);
        renderProducts();

        showSnackbar('Jenis berhasil dihapus.');
    }
}


// ===== LocalStorage for Custom Subcategories =====
function saveCategoriesToStorage() {
    localStorage.setItem('tokoTaniTernak_categories', JSON.stringify(categories));
}

function loadCategoriesFromStorage() {
    const saved = localStorage.getItem('tokoTaniTernak_categories');
    if (saved) {
        try {
            const parsed = JSON.parse(saved);
            // Merge saved subcategories
            for (const key in parsed) {
                if (categories[key]) {
                    categories[key].subcategories = parsed[key].subcategories;
                }
            }
        } catch (e) {
            console.log('Error loading categories:', e);
        }
    }
}

// Load saved categories on startup
loadCategoriesFromStorage();

// ===== Store Settings Logic =====
const defaultStoreSettings = {
    name: 'TokoTaniTernak',
    tagline: 'Katalog Pertanian & Peternakan',
    logo: '🌾🐄'
};

let storeSettings = {
    ...defaultStoreSettings
};

function loadStoreSettings() {
    const saved = localStorage.getItem('tokoTaniTernak_settings');
    if (saved) {
        storeSettings = JSON.parse(saved);
    }
    applyStoreSettings();
}

function applyStoreSettings() {
    document.getElementById('store-name').textContent = storeSettings.name;
    document.getElementById('store-tagline').textContent = storeSettings.tagline;
    document.getElementById('store-logo').textContent = storeSettings.logo;

    // Update title
    document.title = storeSettings.name;
}

function openStoreSettings() {
    document.getElementById('settings-store-name').value = storeSettings.name;
    document.getElementById('settings-store-tagline').value = storeSettings.tagline;
    renderLogoPicker();

    document.getElementById('store-settings-modal').classList.remove('hidden');
}

function closeStoreSettings() {
    document.getElementById('store-settings-modal').classList.add('hidden');
}

function renderLogoPicker() {
    const container = document.getElementById('logo-picker');
    const logos = ['🌾🐄', '🏪', '🚜', '🏡', '👨‍🌾', '🌱', '🏗️', '🏭', '🧺'];

    container.innerHTML = logos.map(logo => `
        <button type="button" class="icon-btn ${logo === storeSettings.logo ? 'selected' : ''}" 
                onclick="selectStoreLogo('${logo}')">
            ${logo}
        </button>
    `).join('');
}

function selectStoreLogo(logo) {
    storeSettings.logo = logo; // Temp update for picker selection
    renderLogoPicker();
}

function saveStoreSettings(event) {
    event.preventDefault();

    storeSettings.name = document.getElementById('settings-store-name').value;
    storeSettings.tagline = document.getElementById('settings-store-tagline').value;

    localStorage.setItem('tokoTaniTernak_settings', JSON.stringify(storeSettings));
    applyStoreSettings();
    closeStoreSettings();
    showSnackbar('Pengaturan toko berhasil disimpan!');
}

function resetStoreSettings() {
    if (confirm('Reset pengaturan toko ke default?')) {
        storeSettings = { ...defaultStoreSettings };
        localStorage.removeItem('tokoTaniTernak_settings');
        applyStoreSettings();
        closeStoreSettings();
        showSnackbar('Pengaturan toko dikembalikan ke default.');
    }
}

// Load settings on startup
loadStoreSettings();

