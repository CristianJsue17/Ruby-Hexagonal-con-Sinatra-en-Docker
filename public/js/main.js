window.onload = function () {
  let cartItems = JSON.parse(localStorage.getItem("cartItems")) || [];
  let open_cart_button = document.getElementById("button-cart");
  let sideCart = document.getElementById("cart-overlay");
  let close_cart_button = document.getElementById("close-cart");
  let addProductButton = document.getElementById("add-to-cart-button");
  let quantitySelect = document.getElementById("product-quantity"); 
  let alertSuccess = document.getElementById("alert-success")

  if(alertSuccess){
    setTimeout(()=>{
      console.log("se eliminara el succes alert")
      // eliminar el alert 
      alertSuccess.remove()

    },1000)
  }

  let deleteProductButtonsCollection = document.getElementsByClassName("delete-button");
  let deleteProductButtons = Array.from(deleteProductButtonsCollection);
  if(deleteProductButtons.length > 0){
    deleteProductButtons.forEach((button) => {
        button.addEventListener("click", function (event) {
            let productId = event.target.dataset.productId;
            fetch(`/admin/products/delete/${productId}`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
            }).then((response) => {
                return response.json();
            }).then((data) => {
                alert(data.message);
                location.reload();
                console.log(data);
            })
        })
    });
  }
  
  function setCartItems(cartItemsNew) {
    console.log("se ejecuto setCartItems");
    cartItems = cartItemsNew;
  }
  function getCartItems() {
    return cartItems;
  }

  open_cart_button.addEventListener("click", function () {
    // aqui cambiamos la clase de la barra del carrito open close
    sideCart.classList.toggle("open");
  });
  close_cart_button.addEventListener("click", function () {
    sideCart.classList.toggle("open");
  });

  if (addProductButton && quantitySelect) {
    addProductButton.addEventListener("click", function (event) {
      let productId = event.target.dataset.productId;
      let productFound = cartItems.find((item) => item.id == productId);
      if (productFound) {

        productFound.quantity += Number(quantitySelect.value);
        let cartItemsUpdated = cartItems.map((item) => {
          if (item.id == productId) {
            item = productFound;
            return item;
          }
          return item;
        });
        cartItems = [...cartItemsUpdated];
        localStorage.setItem("cartItems", JSON.stringify(cartItems));
        add_product_to_card(cartItems,setCartItems,getCartItems);
      } else {
        console.log("haciedno fetch");
        fetch(`/api/products/${productId}`)
          .then((response) => response.json())
          .then((data) => {
            let product = {};
            product.id = data.id;
            product.name = data.name;
            product.price = data.price;
            product.image = data.image.url;
            product.quantity = Number(quantitySelect.value); //data.quantity del input
            cartItems.push(product);
            localStorage.setItem("cartItems", JSON.stringify(cartItems));
            add_product_to_card(cartItems,setCartItems,getCartItems);
          });
      }
    });
  }
  // agregar otra logica aqui.
  add_product_to_card(cartItems,setCartItems,getCartItems);
};

function add_product_to_card(cartItems,setCartItems,getCartItems) {
  console.log("setCartItems",setCartItems);
  let cartContainer = document.getElementById("cart-items");
  // limpiar carContainer
  cartContainer.innerHTML = "";
  cartItems.forEach((item) => {
    let divImg = document.createElement("div");
    divImg.classList.add("img");
    let img = document.createElement("img");
    img.src = item.image;
    img.alt = item.name;
    divImg.appendChild(img);
    let divInfo = document.createElement("div");
    divInfo.classList.add("info");
    let h3 = document.createElement("h3");
    h3.innerText = item.name;
    let p = document.createElement("p");
    p.innerText = item.price;
    let quantity = document.createElement("p");
    quantity.innerText = item.quantity;
    let removeButton = document.createElement("button");
    removeButton.classList.add("remove-from-cart");
    removeButton.dataset.productId = item.id;
    removeButton.innerText = "Eliminar";
    removeButton.addEventListener("click", function (event) {
      let productId = event.target.dataset.productId;
      let cartItemsRemoved = cartItems.filter((item) => item.id != productId);
      setCartItems(cartItemsRemoved);
      localStorage.setItem("cartItems", JSON.stringify(getCartItems()));
      add_product_to_card(getCartItems(),setCartItems,getCartItems);
    });
    divInfo.appendChild(h3);
    divInfo.appendChild(p);
    divInfo.appendChild(quantity);
    divInfo.appendChild(removeButton);
    let product = document.createElement("div");
    product.classList.add("cart-item");
    product.appendChild(divImg);
    product.appendChild(divInfo);
    cartContainer.insertBefore(product, cartContainer.lastElementChild);
  });
}
