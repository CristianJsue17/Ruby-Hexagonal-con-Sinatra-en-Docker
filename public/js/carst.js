
window.onload = function(){
    let ordenTotal = 0
    let carstItems;
    let cartItemsContent;
    let buyButton;
    try {
        carstItems =  JSON.parse(localStorage.getItem("cartItems"));
        // cartItems =  localStorage.getItem("cartItems")? JSON.parse(localStorage.getItem("cartItems")):[]
        if(carstItems){
            console.log("cartsItems",carstItems)
        }
        else{
            throw "no se encontro los items en el localstorage"
        }
    }
    catch (e){
        console.log(e)
    }

    try{
        cartItemsContent = document.getElementById("cart-items")
        if(cartItemsContent){
            console.log("cartItemsContent",cartItemsContent)
        }
        else{
            throw "No se encontro el elemento"
        }
    }
    catch (e){
        console.log(e)
    }

    try {
        buyButton = document.getElementById("checkout")
        if(buyButton){
            console.log("buyButton",buyButton)
        }
    }
    catch (e){
        console(e)
    }

    buyButton.addEventListener("click",()=>{

        let notice = {
            type : "notice",
            message : "su compra se realizo con exito"
        }

        // localStorage.setItem("cartItems","[]")
        localStorage.removeItem("cartItems")
        localStorage.setItem("notice",JSON.stringify(notice))
        window.location.href="/"

    })


    function renderItemsToView(){
        // llenar el div con los cart

        if (carstItems){
            cartItemsContent.innerHTML=""
            carstItems.forEach((item)=>{
                ordenTotal = ordenTotal + (item.quantity * parseFloat(item.price))

                let cartItemElement = document.createElement("div")
                cartItemElement.classList.add("cart-item")
                cartItemElement.classList.add("col-4")
                cartItemElement.classList.add("text-center")
                // cartItemElement.id="cart-item"

                let cartItemHeader = document.createElement("div")
                cartItemHeader.classList.add("cart-item-header")

                let imgHeader = document.createElement("img")
                imgHeader.src = `${item.image}`
                imgHeader.classList.add("product-image-container")

                let divContentHeader = document.createElement("div")

                let h3 = document.createElement("h3")
                h3.textContent = `${item.name}`
                h3.classList.add("fs-5")

                let p = document.createElement("p")
                p.classList.add("text-sm")
                p.classList.add("text-gray-600")
                p.textContent = `Precio: $ ${item.price}`

                divContentHeader.append(h3)
                divContentHeader.append(p)

                cartItemHeader.append(imgHeader)
                cartItemHeader.append(divContentHeader)



                let cartItemFooter = document.createElement("div")
                cartItemFooter.classList.add("product-footer")

                let pFooter = document.createElement("p")
                pFooter.classList.add("product-quantity")
                pFooter.textContent = `Cantidad : ${item.quantity}`

                let deleteButtonContainer = document.createElement("div")
                deleteButtonContainer.classList.add("delete-button-container")

                let deletButton = document.createElement("button")
                deletButton.classList.add("delete-button")
                deletButton.classList.add("w-100")
                deletButton.setAttribute("data-product-id",`${item.id}`)
                deletButton.textContent="Eliminar"
                deletButton.addEventListener("click",(e)=>{
                    let id = e.target.getAttribute("data-product-id")

                    let foundElement = carstItems.find(item=> item.id==Number(id))
                    console.log("foudn element",foundElement)
                    if (foundElement){
                        let carstItemsUpdate = carstItems.filter(item => item.id!=foundElement.id)
                        // console.log("array modificado",carstItemsUpdate)
                        carstItems = [...carstItemsUpdate]
                        ordenTotal=0
                        localStorage.setItem("cartItems",JSON.stringify(carstItems))
                        renderItemsToView()
                    }

                })

                deleteButtonContainer.append(deletButton)
                cartItemFooter.append(pFooter)
                cartItemFooter.append(deleteButtonContainer)

                cartItemElement.append(cartItemHeader)
                cartItemElement.append(cartItemFooter)
                cartItemsContent.append(cartItemElement)
            })
            let totalDiv=document.getElementById("total")
            totalDiv.textContent = `S/. ${ordenTotal}`
        }
        else{
            let emptyContentCartItems = document.createElement("div")
            emptyContentCartItems.classList.add("alert")
            emptyContentCartItems.classList.add("alert-warning")
            emptyContentCartItems.textContent = "El carrito esta vacio"
            cartItemsContent.append(emptyContentCartItems)
        }
    }

    renderItemsToView()
}

