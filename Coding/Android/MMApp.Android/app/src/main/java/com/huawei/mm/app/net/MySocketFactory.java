package com.huawei.mm.app.net;

import android.content.Context;

import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.security.KeyStore;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;

public class MySocketFactory extends SSLSocketFactory {
	
	private String TAG = MySocketFactory.class.getCanonicalName();

	private SSLContext sslContext;
	public static final String KEY_STORE_TYPE_BKS = "bks";// 证书类型 固定值
	public static final String KEY_STORE_TYPE_P12 = "PKCS12";// 证书类型 固定值
	private static final String KEY_STORE_CLIENT_PATH = "client.p12";// 客户端要给服务器端认证的证书
	private static final String KEY_STORE_TRUST_PATH = "client.truststore";// 客户端验证服务器端的证书库
	private static String KEY_STORE_PASSWORD = "123456";// 客户端证书密码
	private static String KEY_STORE_TRUST_PASSWORD = "123456";// 客户端证书库密码
	private static String X509 = "X509";
	private static String TLS_v1 = "TLSv1.1";
	private static String TLS_v2 = "TLSv1.2";

	public MySocketFactory(Context context) {
		try {
			// 服务器端需要验证的客户端证书
			KeyStore keyStore = KeyStore.getInstance(KEY_STORE_TYPE_P12);
			// 客户端信任的服务器端证书
			final KeyStore trustStore = KeyStore.getInstance(KEY_STORE_TYPE_BKS);
//			InputStream ksIn = context.getResources().openRawResource(R.raw.client);
//			InputStream tsIn = context.getResources().openRawResource(R.raw.client_server);
			InputStream ksIn = context.getResources().getAssets().open(KEY_STORE_CLIENT_PATH);
			InputStream tsIn = context.getResources().getAssets().open(KEY_STORE_TRUST_PATH);
			try {
				keyStore.load(ksIn, KEY_STORE_PASSWORD.toCharArray());
				trustStore.load(tsIn,KEY_STORE_TRUST_PASSWORD.toCharArray());
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					ksIn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				try {
					tsIn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			sslContext = SSLContext.getInstance(TLS_v2);
			//信任管理
//			TrustManagerFactory trustManagerFactory = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
//			trustManagerFactory.init(trustStore);
			//密钥管理
			KeyManagerFactory keyManagerFactory = KeyManagerFactory.getInstance(X509);
			keyManagerFactory.init(keyStore, KEY_STORE_PASSWORD.toCharArray());

			final TrustManager[] verifyTrustCerts = new TrustManager[]{new X509TrustManager() {
				@Override
				public void checkClientTrusted(java.security.cert.X509Certificate[] chain,String authType) throws CertificateException {
				}

				@Override
				public void checkServerTrusted(java.security.cert.X509Certificate[] chain,String authType) throws CertificateException {
					if (chain == null) {
						throw new IllegalArgumentException("checkServerTrusted:x509Certificate array isnull");
					}

					if (!(chain.length > 0)) {
						throw new IllegalArgumentException("checkServerTrusted: X509Certificate is empty");
					}

					if (!(null != authType && authType.equalsIgnoreCase("RSA"))) {
						throw new CertificateException("checkServerTrusted: AuthType is not RSA");
					}

					// Perform customary SSL/TLS checks
					try {
						TrustManagerFactory tmf = TrustManagerFactory.getInstance("X509");
						tmf.init(trustStore);
						for (TrustManager trustManager : tmf.getTrustManagers()) {
							((X509TrustManager) trustManager).checkServerTrusted(chain, authType);
						}
					} catch (Exception e) {
						throw new CertificateException(e);
					}
				}

				@Override
				public java.security.cert.X509Certificate[] getAcceptedIssuers() {
					return new X509Certificate[0];
				}
			}};

			//初始化
			sslContext.init(keyManagerFactory.getKeyManagers(),verifyTrustCerts, null);
			sslContext.getSocketFactory();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public String[] getDefaultCipherSuites() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String[] getSupportedCipherSuites() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Socket createSocket(Socket socket, String host, int port,
			boolean autoClose) throws IOException {
		SSLSocket sslSocket = (SSLSocket)sslContext.getSocketFactory().createSocket(socket, host, port, autoClose);
		sslSocket.setEnabledProtocols(new String[] {TLS_v1, TLS_v2} );
		return sslSocket;
	}


	@Override
	public Socket createSocket(String host, int port, InetAddress localHost,
			int localPort) throws IOException, UnknownHostException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Socket createSocket(InetAddress host, int port) throws IOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Socket createSocket(InetAddress address, int port,
			InetAddress localAddress, int localPort) throws IOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Socket createSocket(String host, int port) throws IOException,
	UnknownHostException {
		// TODO Auto-generated method stub
		return null;
	}

	private Socket enableTLSOnSocket(Socket socket) {
		if(socket != null && (socket instanceof SSLSocket)) {
			((SSLSocket)socket).setEnabledProtocols(new String[] {"TLSv1", "TLSv1.1", "TLSv1.2"});
		}
		return socket;
	}

}
