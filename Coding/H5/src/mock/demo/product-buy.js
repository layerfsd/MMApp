
module.exports = {
    api: '/product/buy',
    response: function (req, res) {
        var success = true;
        if (Math.random() > 0.5) {
          success = true;
        } else {
          success = false;
        }

        res.json({
            success: success
        });
    }

}