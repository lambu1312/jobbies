<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jobbies Chatbot</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
        }

        /* Chatbot Button */
        .chatbot-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            z-index: 999;
            transition: all 0.3s ease;
        }

        .chatbot-btn:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        }

        /* Chatbot Container */
        .chatbot-container {
            position: fixed;
            bottom: 100px;
            right: 30px;
            width: 380px;
            height: 500px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 40px rgba(0,0,0,0.16);
            display: none;
            flex-direction: column;
            z-index: 999;
            overflow: hidden;
        }

        .chatbot-container.active {
            display: flex;
            animation: slideUp 0.3s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Header */
        .chatbot-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chatbot-header h3 {
            margin: 0;
            font-size: 18px;
        }

        .chatbot-close {
            background: none;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .chatbot-close:hover {
            transform: rotate(90deg);
        }

        /* Messages */
        .chatbot-messages {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .message {
            display: flex;
            gap: 8px;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .message.bot {
            justify-content: flex-start;
        }

        .message.user {
            justify-content: flex-end;
        }

        .message-content {
            max-width: 70%;
            padding: 10px 14px;
            border-radius: 8px;
            word-wrap: break-word;
            line-height: 1.4;
            white-space: pre-line;
        }

        .message.bot .message-content {
            background: #e8e8e8;
            color: #333;
        }

        .message.user .message-content {
            background: #667eea;
            color: white;
        }

        /* Input */
        .chatbot-input {
            padding: 15px;
            border-top: 1px solid #e0e0e0;
            display: flex;
            gap: 10px;
        }

        .chatbot-input input {
            flex: 1;
            border: 1px solid #ddd;
            border-radius: 20px;
            padding: 10px 15px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }

        .chatbot-input input:focus {
            border-color: #667eea;
        }

        .chatbot-send {
            background: #667eea;
            color: white;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.2s;
        }

        .chatbot-send:hover {
            background: #764ba2;
        }

        .typing {
            display: flex;
            gap: 4px;
            padding: 10px 14px;
            background: #e8e8e8;
            border-radius: 8px;
            width: fit-content;
        }

        .typing span {
            width: 8px;
            height: 8px;
            background: #999;
            border-radius: 50%;
            animation: typing 1.4s infinite;
        }

        .typing span:nth-child(2) {
            animation-delay: 0.2s;
        }

        .typing span:nth-child(3) {
            animation-delay: 0.4s;
        }

        @keyframes typing {
            0%, 60%, 100% { opacity: 0.3; }
            30% { opacity: 1; }
        }

        @media (max-width: 480px) {
            .chatbot-container {
                width: calc(100vw - 20px);
                height: calc(100vh - 100px);
                right: 10px;
                bottom: 80px;
            }
        }
    </style>
</head>
<body>
    <!-- Chatbot Button -->
    <button class="chatbot-btn" onclick="toggleChat()">
        <i class="fas fa-comments"></i>
    </button>

    <!-- Chatbot Container -->
    <div class="chatbot-container" id="chatContainer">
        <!-- Header -->
        <div class="chatbot-header">
            <h3>🤖 Jobbies Assistant</h3>
            <button class="chatbot-close" onclick="toggleChat()">
                <i class="fas fa-times"></i>
            </button>
        </div>

        <!-- Messages -->
        <div class="chatbot-messages" id="messages">
            <div class="message bot">
                <div class="message-content">Xin chào! 👋 Tôi là trợ lý AI của Jobbies. Tôi có thể giúp gì cho bạn?
                </div>
            </div>
        </div>

        <!-- Input -->
        <div class="chatbot-input">
            <input 
                type="text" 
                id="messageInput" 
                placeholder="Nhập tin nhắn..." 
                onkeypress="handleKeyPress(event)"
            >
            <button class="chatbot-send" onclick="sendMessage()">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>

    <script>
        // Toggle chat
        function toggleChat() {
            const container = document.getElementById('chatContainer');
            container.classList.toggle('active');
            if (container.classList.contains('active')) {
                document.getElementById('messageInput').focus();
            }
        }

        // Handle Enter key
        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                sendMessage();
            }
        }

        // Send message
        async function sendMessage() {
            const input = document.getElementById('messageInput');
            const message = input.value.trim();
            
            if (!message) return;

            // Add user message
            addMessage(message, 'user');
            input.value = '';

            // Show typing
            showTyping();

            try {
                const contextPath = '<%= request.getContextPath() %>';
                const response = await fetch(contextPath + '/chatbot', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'message=' + encodeURIComponent(message)
                });

                const data = await response.json();
                removeTyping();

                if (data.status === 'success' && data.reply) {
                    addMessage(data.reply, 'bot');
                } else if (data.error) {
                    console.error('API Error:', data.error);
                    addMessage('Xin lỗi, đã có lỗi xảy ra: ' + data.error, 'bot');
                } else {
                    addMessage('Xin lỗi, đã có lỗi xảy ra. Vui lòng thử lại.', 'bot');
                }
            } catch (error) {
                console.error('Error:', error);
                removeTyping();
                addMessage('Không thể kết nối đến server. Vui lòng kiểm tra kết nối.', 'bot');
            }
        }

        // Add message
        function addMessage(text, sender) {
            const messagesDiv = document.getElementById('messages');
            const messageDiv = document.createElement('div');
            messageDiv.className = 'message ' + sender;
            messageDiv.innerHTML = '<div class="message-content">' + text + '</div>';
            messagesDiv.appendChild(messageDiv);
            messagesDiv.scrollTop = messagesDiv.scrollHeight;
        }

        // Show typing
        function showTyping() {
            const messagesDiv = document.getElementById('messages');
            const typingDiv = document.createElement('div');
            typingDiv.className = 'message bot';
            typingDiv.id = 'typing';
            typingDiv.innerHTML = '<div class="typing"><span></span><span></span><span></span></div>';
            messagesDiv.appendChild(typingDiv);
            messagesDiv.scrollTop = messagesDiv.scrollHeight;
        }

        // Remove typing
        function removeTyping() {
            const typing = document.getElementById('typing');
            if (typing) typing.remove();
        }
    </script>
</body>
</html>
