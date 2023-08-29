function trackMouseInteractions({ event = 'click', customEventName = 'click-event', endpoint = 'http://localhost:5100', }) {
  function handleMouseEvent(event) {
    const urlActual = window.location.href;
    const { pageX, pageY, target } = event;
    const fechaActual = new Date();
    const interactionData = {
      event: customEventName,
      mouseX: `${pageX}px`,
      mouseY: `${pageY}px`,
      windowWidth: `${document.body.scrollWidth}px`,
      windowHeight: `${document.body.scrollHeight}px`,
      date: fechaActual.toISOString(),
      html: target.outerHTML,
      url: urlActual,
    };

    fetch(endpoint, {
      method: 'POST',
      body: JSON.stringify(interactionData),
    })
  }

  document.addEventListener(event, handleMouseEvent);

  return function stopTracking() {
    document.removeEventListener(event, handleMouseEvent);
  };
}
