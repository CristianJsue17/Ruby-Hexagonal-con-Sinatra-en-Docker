document.addEventListener("DOMContentLoaded", () => {
    const container = document.querySelector(".login-container");
  
    // Agregar sombra animada al pasar el ratón
    container.addEventListener("mouseenter", () => {
      container.style.boxShadow = "0 0 30px rgba(0, 255, 255, 0.8), 0 0 50px rgba(0, 255, 255, 0.5)";
      container.style.transition = "box-shadow 0.3s ease-in-out";
    });
  
    container.addEventListener("mouseleave", () => {
      container.style.boxShadow = "0 0 15px rgba(0, 255, 255, 0.5), 0 0 30px rgba(0, 255, 255, 0.2)";
      container.style.transition = "box-shadow 0.3s ease-in-out";
    });
  
    // Crear animación de borde con gradiente
    let angle = 0;
    setInterval(() => {
      angle += 1;
      container.style.borderImage = `linear-gradient(${angle}deg, rgba(0, 255, 255, 0.7), rgba(0, 150, 255, 0.7)) 1`;
    }, 50);
  })  