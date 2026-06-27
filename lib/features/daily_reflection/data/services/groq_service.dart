import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GroqService {
  static const _baseUrl = 'https://api.groq.com/openai/v1/chat/completions';
  static const _model   = 'llama-3.3-70b-versatile';

  String get _apiKey => dotenv.env['GROQ_API_KEY'] ?? '';

  Future<Map<String, dynamic>> generateReflection(String userInput) async {
    final prompt = '''
Eres Reflecta, un guía espiritual cristiano sabio, cálido y profundo para jóvenes.
El usuario ha compartido cómo fue su día. Tu tarea es responder SOLO con un JSON válido, sin texto adicional, sin bloques de código.

Responde en español con este formato exacto:
{
  "reflection": "Una reflexión profunda y personalizada de 2-3 oraciones sobre lo que vivió el usuario, conectando su experiencia con la fe cristiana.",
  "verse": "El texto completo del versículo bíblico más relevante para su situación.",
  "verseReference": "Libro capítulo:versículo (ej: Juan 3:16)",
  "spiritualInsight": "Un insight espiritual práctico de 1-2 oraciones que le ayude a ver su situación desde la perspectiva de Dios.",
  "actionPlan": ["Acción concreta 1", "Acción concreta 2", "Acción concreta 3"]
}

Lo que el usuario compartió:
"$userInput"
''';

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': _model,
        'messages': [
          {'role': 'system', 'content': 'Eres Reflecta, un guía espiritual cristiano. Responde ÚNICAMENTE con JSON válido, sin texto adicional.'},
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0.85,
        'max_tokens': 1024,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error Groq: ${response.statusCode} — ${response.body}');
    }

    final body = jsonDecode(response.body);
    final content = body['choices'][0]['message']['content'] as String;

    // Limpiar posibles bloques de código
    final clean = content
      .replaceAll('```json', '')
      .replaceAll('```', '')
      .trim();

    return jsonDecode(clean) as Map<String, dynamic>;
  }
}
