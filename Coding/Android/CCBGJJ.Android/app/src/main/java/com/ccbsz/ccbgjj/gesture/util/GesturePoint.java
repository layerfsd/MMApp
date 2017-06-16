package com.ccbsz.ccbgjj.gesture.util;

import android.provider.SyncStateContract;
import android.widget.ImageView;

import com.ccbsz.ccbgjj.R;

/**
 * Created by CCB on 2016/12/7.
 */

public class GesturePoint {
    /**
     * 左边x的值
     * */
    private int leftX;
    /**
     * 右边x的值
     * */
    private int rightX;
    /**
     * 上边Y的值
     * */
    private int topY;
    /**
     * 下边Y的值
     * */
    private int bottomY;
    /***
     * 这个点对应的ImageView控件
     */
    private ImageView image;
    /**
     * 中心值X
     */
    private int centerX;
    /**
     * 中心值Y
     */
    private int centerY;
    /***
     * 状态值
     */
    private int pointState;
    /**
     * 代表这个Point对象代表的数字，从1开始(直接感觉从1开始)
     */
    private int num;

    public GesturePoint(int leftX, int rightX, int topY, int bottomY, ImageView image, int num) {
        this.leftX = leftX;
        this.rightX = rightX;
        this.topY = topY;
        this.bottomY = bottomY;
        this.image = image;
        this.num = num;
        this.centerX=(leftX+rightX)/2;
        this.centerY=(topY+bottomY)/2;
    }

    public int getLeftX() {
        return leftX;
    }

    public void setLeftX(int leftX) {
        this.leftX = leftX;
    }

    public int getRightX() {
        return rightX;
    }

    public void setRightX(int rightX) {
        this.rightX = rightX;
    }

    public int getTopY() {
        return topY;
    }

    public void setTopY(int topY) {
        this.topY = topY;
    }

    public int getBottomY() {
        return bottomY;
    }

    public void setBottomY(int bottomY) {
        this.bottomY = bottomY;
    }

    public ImageView getImage() {
        return image;
    }

    public void setImage(ImageView image) {
        this.image = image;
    }

    public int getCenterX() {
        return centerX;
    }

    public void setCenterX(int centerX) {
        this.centerX = centerX;
    }

    public int getCenterY() {
        return centerY;
    }

    public void setCenterY(int centerY) {
        this.centerY = centerY;
    }

    public int getPointState() {
        return pointState;
    }

    public void setPointState(int pointState) {
        this.pointState=pointState;
        switch (pointState){
            case GestureGlobals.POINT_STATE_NORMAL:
                //2017-02-21 add liuym 当状态回调默认时，需要重新设置图片
                this.image.setBackgroundResource(R.mipmap.gesture_node_normal);
                break;
            case GestureGlobals.POINT_STATE_SELECTED:
                this.image.setBackgroundResource(R.mipmap.gesture_node_pressed);
                break;
            case GestureGlobals.POINT_STATE_WRONG:
                this.image.setBackgroundResource(R.mipmap.gesture_node_wrong);
                break;
        }
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }
}
