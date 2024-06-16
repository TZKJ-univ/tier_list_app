//巨大画像のアップロード防止
document.addEventListener("turbo:load", function(){
    document.addEventListener("change", function(event) {
        let image_upload = document.querySelector('#micropost_image');
        if (image_upload && image_upload.files.length > 0) {
            const size_in_megabytes = image_upload.files[0].size/1024/1024;
            if (size_in_megabytes > 5) {
                alert("Maximum file size is 5MB. Please choose a smallerfile.");
                image_upload.value = "";
            }
        } 
    });
});