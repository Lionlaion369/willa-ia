import React, { useState } from 'react';
import { SafeAreaView, View, Text, TextInput, Button, ScrollView, TouchableOpacity } from 'react-native';
import * as Speech from 'expo-speech';
import axios from 'axios';
import { OPENAI_API_KEY } from '@env';

export default function App() {
  const [input, setInput] = useState('');
  const [messages, setMessages] = useState([]);
  const [loading, setLoading] = useState(false);

  async function sendToWilla(text) {
    if (!text) return;
    setLoading(true);
    const userMsg = { role: 'user', content: text };
    setMessages(prev => [...prev, { from: 'user', text }]);

    try {
      const res = await axios.post('https://api.openai.com/v1/chat/completions', {
        model: 'gpt-5',
        messages: [userMsg],
        max_tokens: 800
      }, {
        headers: {
          Authorization: `Bearer ${OPENAI_API_KEY}`,
          'Content-Type': 'application/json'
        }
      });

      const reply = res.data.choices?.[0]?.message?.content || 'Desculpe, não entendi.';
      setMessages(prev => [...prev, { from: 'willa', text: reply }]);
      Speech.speak(reply);

    } catch (err) {
      console.error(err?.response?.data || err.message || err);
      const errMsg = 'Erro ao contatar Willa.';
      setMessages(prev => [...prev, { from: 'willa', text: errMsg }]);
      Speech.speak(errMsg);
    } finally {
      setLoading(false);
      setInput('');
    }
  }

  return (
    <SafeAreaView style={{ flex: 1, padding: 12 }}>
      <View style={{ flex: 1 }}>
        <ScrollView style={{ flex: 1, marginBottom: 12 }}>
          {messages.map((m, i) => (
            <View key={i} style={{ marginVertical: 6 }}>
              <Text style={{ fontWeight: m.from === 'user' ? '700' : '600' }}>{m.from.toUpperCase()}</Text>
              <Text>{m.text}</Text>
            </View>
          ))}
        </ScrollView>

        <View style={{ flexDirection: 'row', gap: 8, alignItems: 'center' }}>
          <TextInput
            value={input}
            onChangeText={setInput}
            placeholder="Fale com a Willa..."
            style={{ flex: 1, borderWidth: 1, borderRadius: 8, padding: 8 }}
          />
          <TouchableOpacity onPress={() => sendToWilla(input)} disabled={loading} style={{ padding: 10, backgroundColor: '#0a84ff', borderRadius: 8 }}>
            <Text style={{ color: '#fff' }}>{loading ? '...' : 'Enviar'}</Text>
          </TouchableOpacity>
        </View>
      </View>
    </SafeAreaView>
  );
}
