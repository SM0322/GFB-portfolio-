if (document.URL.match(/new/) || document.URL.match(/edit/)){
  document.addEventListener('DOMContentLoaded', () => {
    const createImageHTML = (blob) => {                                          
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'new-img');
      blobImage.setAttribute('src', blob);
      
      imageElement.appendChild(blobImage);
    };
    document.getElementById('post_images').addEventListener('change', (e) =>{
      const imageContents = $(".new-img");
      $.each(imageContents, function(idx, val) {
        val.remove();
      });
      
      const files = e.target.files;
      for (let i = 0; i < files.length; i++) {
        const blob = window.URL.createObjectURL(files[i]);
        createImageHTML(blob);
      };
    });
  });
}