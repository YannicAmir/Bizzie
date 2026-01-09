import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class IVertexAIProvider {
  GenerativeModel getModel(String modelName, GenerationConfig config);
}

@Injectable(as: IVertexAIProvider)
class VertexAIProvider implements IVertexAIProvider {
  @override
  GenerativeModel getModel(String modelName, GenerationConfig config) {
    final vertexInstance = FirebaseAI.vertexAI(auth: FirebaseAuth.instance);
    return vertexInstance.generativeModel(
      model: modelName,
      generationConfig: config,
    );
  }
}
