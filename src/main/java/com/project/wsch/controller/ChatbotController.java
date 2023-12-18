package com.project.wsch.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.Date;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;



@RestController
public class ChatbotController {
	   String apiURL = "https://xf8qrb7e44.apigw.ntruss.com/custom/v1/12844/ed4b1c6a172b02be6d4ec688b9e226a2ca5e726135bb07650b5daebeb45980ca";
	   String secretKey = "YnJGSXlrd0lPd2tWaU9jcWRETVN5RU1vZmlGTnBYWVE=";
	   @GetMapping("/chatbot")
	public ModelAndView chatForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/wsch_intro");
		return mav;
	}
	//
	@RequestMapping(value="/chatbotMessage", method=RequestMethod.POST, produces="application/text;charset=UTF-8")
	//@PostMapping("/chatbotMessage")
	public String chatbotMessage(@RequestParam("queryin") String queryin) {
		
		String chatbotMessage = ""; //응답결과 담을 변수

        try {
            //String apiURL = "https://ex9av8bv0e.apigw.ntruss.com/custom_chatbot/prod/";

            URL url = new URL(apiURL);

            String message = getReqMessage(queryin);
            System.out.println("##" + message);

            String encodeBase64String = makeSignature(message, secretKey);

            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json;UTF-8");
            con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);

            // post request
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.write(message.getBytes("UTF-8"));
            wr.flush();
            wr.close();
                        
            int responseCode = con.getResponseCode();

            BufferedReader br;

            if(responseCode==200) { // Normal call
                System.out.println(con.getResponseMessage());

                BufferedReader in = new BufferedReader(
                        new InputStreamReader(
                                con.getInputStream(),"UTF-8"));
                String decodedString;
                while ((decodedString = in.readLine()) != null) {
                    chatbotMessage = decodedString;
                }
                //chatbotMessage = decodedString;
                in.close();

            } else {  // Error occurred
                chatbotMessage = con.getResponseMessage();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        System.out.println("--->"+chatbotMessage);
        return chatbotMessage;		
	}
	//
    public static String getReqMessage(String voiceMessage) {
        String requestBody = "";
        try {
            JSONObject obj = new JSONObject();
            long timestamp = new Date().getTime();
            System.out.println("##"+timestamp);
            obj.put("version", "v2");
            obj.put("userId", "U47b00b58c90f8e47428af8b7bddc1231heo2");
//=> userId is a unique code for each chat user, not a fixed value, recommend use UUID. use different id for each user could help you to split chat history for users.
            obj.put("timestamp", timestamp);
            
            JSONObject bubbles_obj = new JSONObject();
            bubbles_obj.put("type", "text");
            
            JSONObject data_obj = new JSONObject();
            data_obj.put("description", voiceMessage);
            bubbles_obj.put("type", "text");
            bubbles_obj.put("data", data_obj);
            
            JSONArray bubbles_array = new JSONArray();
            bubbles_array.put(bubbles_obj);
            obj.put("bubbles", bubbles_array);
            obj.put("event", "send");
            
            requestBody = obj.toString();
            System.out.println(requestBody);
        } catch (Exception e){
            System.out.println("## Exception : " + e);
        }
        return requestBody;
    }
    //===================
    public static String makeSignature(String message, String secretKey) {

        String encodeBase64String = "";

        try {
            byte[] secrete_key_bytes = secretKey.getBytes("UTF-8");

            SecretKeySpec signingKey = new SecretKeySpec(secrete_key_bytes, "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);

            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
            encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
            
            return encodeBase64String;

        } catch (Exception e){
            System.out.println(e);
        }

        return encodeBase64String;
    }
}
