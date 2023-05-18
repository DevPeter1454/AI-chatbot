import 'dart:convert';

import 'package:ask_ai/core/models/stable_diffusion_image_model.dart';
import 'package:ask_ai/ui/common/constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final log = Logger();

class ApiService {
  Future<dynamic> getImageResponse(String prompt) async {
    try {
      final response = await http.post(
          Uri.parse(
            textToImageEndpoint,
          ),
          body: jsonEncode({
            'key': apiKey,
            'prompt': prompt,
            'negative_prompt': negativePrompt,
            'width': 512,
            'height': 512,
            'samples': 1,
            "num_inference_steps": "20",
            "seed": null,
            "guidance_scale": 7.5,
            "safety_checker": "yes",
            "webhook": null,
            "track_id": null
          }),
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        log.d(jsonDecode(response.body));
        if (jsonDecode(response.body)['status'] == 'processing') {
          return {
            'status': 'processing',
            'data': StableDiffusionImageResponseModel.fromJson(response.body)
          };
        } else {
          return {
            'status': 'completed',
            'data': StableDiffusionImageModel.fromJson(response.body)
          };
        }
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      log.e(e);
      throw Exception('Failed to load image');
    }
  }

  Future<StableDiffusionImageModel> getImageLink(String url) async {
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'key': apiKey,
          }),
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        log.d(jsonDecode(response.body));

        return StableDiffusionImageModel.fromJson(response.body);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      log.e(e);
      throw Exception('Failed to load image');
    }
  }
}
