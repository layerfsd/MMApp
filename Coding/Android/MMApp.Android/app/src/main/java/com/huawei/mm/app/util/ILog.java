package com.huawei.mm.app.util;

import android.os.Environment;
import android.util.Log;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 日志的功能操作类 
 * 
 * @author Remind
 */
public class ILog {

	private static String TAG = ILog.class.getCanonicalName();
	
    /**
     * DEBUG级别
     */
	public static  boolean DEBUG = true;
	
    /**
     * DEBUG_ERROR级别
     */
	private static boolean DEBUG_ERROR = true;

	/**
	 * 是否保存至SD�?
	 */
	private static final boolean SAVE_TO_SD = false;

	/**
	 * 保存LOG日志的目�?
	 */
	private static String LogDirPath;

	/**
	 * 日志打印时间Format
	 */
    private static final SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static final SimpleDateFormat LOG_FMT = new SimpleDateFormat("yyyy-MM-dd");
    
    public static void closeDebug(){
    	DEBUG = false;
    	DEBUG_ERROR = false;
    }
    
    public static void openDebug(){
    	DEBUG = true;
    	DEBUG_ERROR = true;
    }
    
    /**
     * 设置Log保存目录
     * @param dir
     */
    public static void setLogDirPath(String dir) {
    	LogDirPath = dir;
    }
    
    /**
     * 获取Log保存目录
     * @return
     */
    public static String getLogDirPath() {
    	return LogDirPath;
    }

	/**
	 * 用于打印错误级的日志信息
	 * @param strModule LOG TAG
	 * @param strErrMsg 打印信息
	 */
	public static void e(String strModule, String strErrMsg) {
		if (DEBUG_ERROR) {
			Log.e(strModule, "----" + strErrMsg + "----");
			if (SAVE_TO_SD) {
				storeLog(strModule, strErrMsg);
			}
		}
	}
	
	/**
	 * 用于打印异常的的日志信息
	 * @param strModule LOG TAG
	 * @param strErrMsg 打印信息
	 */
	public static void e(String strModule, String strErrMsg, Exception e) {
		if (DEBUG_ERROR) {
			Log.e(strModule, "----" + strErrMsg + "----", e);
			if (SAVE_TO_SD) {
				storeLog(strModule, strErrMsg);
			}
		}
	}

    /**
     * 用于打印描述级的日志信息
     * @param strModule LOG TAG
     * @param strErrMsg 打印信息
     */
	public static void d(String strModule, String strErrMsg) {
		if (DEBUG) {
			Log.d(strModule, "----" + strErrMsg + "----");
            if (SAVE_TO_SD) {
                storeLog(strModule, strErrMsg);
            }
		}
	}
	
	/**
	 * 用于打印info级的日志信息
	 * @param strModule LOG TAG
	 * @param strErrMsg 打印信息
	 */
	public static void i(String strModule, String strErrMsg) {
		if (DEBUG) {
			Log.i(strModule, "----" + strErrMsg + "----");
			if (SAVE_TO_SD) {
				storeLog(strModule, strErrMsg);
			}
		}
	}
	
	/**
	 * 用于打印v级的日志信息
	 * @param strModule LOG TAG
	 * @param strErrMsg 打印信息
	 */
	public static void v(String strModule, String strErrMsg) {
		if (DEBUG) {
			Log.v(strModule, "----" + strErrMsg + "----");
			if (SAVE_TO_SD) {
				storeLog(strModule, strErrMsg);
			}
		}
	}
	
	/**
	 * 用于打印w级的日志信息
	 * @param strModule LOG TAG
	 * @param strErrMsg 打印信息
	 */
	public static void w(String strModule, String strErrMsg) {
		if (DEBUG) {
			Log.w(strModule, "----" + strErrMsg + "----");
			if (SAVE_TO_SD) {
				storeLog(strModule, strErrMsg);
			}
		}
	}

    /**
     * 将日志信息保存至SD�?
     * @param strModule LOG TAG
     * @param strErrMsg 保存的打印信�?
     */
	public static void storeLog(String strModule, String strErrMsg) {
		if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
			synchronized (LOG_FMT) {
				String logname = LOG_FMT.format(new Date(System.currentTimeMillis())) + ".txt";
				
				File file = new File(getLogDirPath() + "/" + logname);
				// 判断日志文件是否已经存在
				if (!file.exists()) {
					try {
						file.createNewFile();
					}
					catch (IOException e) {
						e(TAG, "" +e);
					}
				}
				try {
					// 输出
					FileOutputStream fos = new FileOutputStream(file, true);
					PrintWriter out = new PrintWriter(fos);
					
					out.println(fmt.format(System.currentTimeMillis()) + "  >>" + strModule + "<<  " + strErrMsg + '\r');
					out.flush();
					out.close();
					
				}
				catch (FileNotFoundException e1) {
					e1.printStackTrace();
				}
				catch (Exception e) {
					e(TAG, "" +e);
				}
			}
		}
	}
	/**
	 * 获取DEBUG状�?
	 * @return
	 */
	public static boolean isDebuggable() {
	    return DEBUG;
	}
	
	/**
	 * 用于打印wr级的日志信息
	 * @param strModule LOG TAG
	 * @param strErrMsg 打印信息
	 */
	public static void wr(String strModule, String strErrMsg) {
		if (DEBUG) {
			Log.w(strModule, "----" + strErrMsg + "----");
			storeLog(strModule, strErrMsg);
		}
	}
}
