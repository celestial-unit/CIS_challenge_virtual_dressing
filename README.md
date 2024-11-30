CIS/ZEN Challenge Virtual Dressing

A computer vision and AI project that enables virtual try-on by fusing image data with clothing and body models to generate realistic virtual dressing.
<p align="center"> <img src="/api/placeholder/800/400" alt="Virtual Dressing Workflow"> </p>
Description

This project combines state-of-the-art deep learning models for virtual dressing, using both half-body and full-body datasets, enabling users to virtually try on clothes and receive outfit recommendations.
Key Features

    Clothing and body model fusion for virtual try-on
    Controllable image generation using latent diffusion models
    Human parsing and pose detection
    Full-body and half-body outfit simulations
    Integration with advanced AI models for better fit and appearance

System Components
1. Computer Vision Recognition

    2D body and clothing recognition from input images
    Garment segmentation and alignment for proper fit
    Integration of VITON-HD (half-body) and Dress Code (full-body) datasets
    Image generation using latent diffusion models

2. Virtual Try-On Integration

    Clothing and body model pairing for virtual simulation
    Integration of advanced human parsing models (e.g., OpenPose)
    Clothing category classification (e.g., upperbody, lowerbody, dress)
    Latent diffusion models for realistic image synthesis

3. Model Workflow

    Input image preprocessing (body and clothing)
    Segmentation and alignment of clothing items
    Model-based fusion of clothing with body image
    Image generation with controllable parameters (e.g., fit, scale)
    Output the final virtual try-on image

Requirements

pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2
pip install -r requirements.txt
pip install opencv-python
pip install HuggingFace
pip install clip-vit-large-patch14

Usage
Basic Usage

python run_ootd.py --model_path <model-image-path> --cloth_path <cloth-image-path> --scale 2.0 --sample 4

Example Output

Generated Image: <path-to-output-image>
Virtual Try-On: True
Outfit Recommendation: Yes

Model Architecture

The model integrates latent diffusion techniques for generating realistic images of clothing and human body models:

    Deep learning-based segmentation for human body parts
    Clothing item fusion and virtual try-on generation using pre-trained models

Error Handling

The system includes robust error handling for:

    Invalid input images
    Misalignment of clothing with body
    Failed model generation due to missing data

Limitations

    Clear input images are required for optimal results
    Current models are trained for specific body types and clothing styles
    Image quality directly affects the final output

Future Improvements

    Enhanced Image Recognition:
        Better handling of varied body types and clothing styles
        Integration of more advanced garment fitting techniques

    Model Performance:
        Faster inference times for real-time applications
        Optimization of model for higher-quality virtual try-on outputs

    User Experience:
        User interface enhancements for easier interaction
        Multi-outfit recommendation system

Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
Acknowledgments

    VITON-HD dataset
    Dress Code dataset
    OpenPose model for human parsing
    HuggingFace for model hosting

References

    VITON-HD - Half-body virtual try-on dataset
    Dress Code - Full-body virtual try-on dataset
    OpenPose - Human parsing and pose estimation
    CLIP - Text and image model for clothing analysis

Basic Usage

    python run_ootd.py --model_path <model-image-path> --cloth_path <cloth-image-path> --scale 2.0 --sample 4

Example Output

    Generated Image: <path-to-output-image>
    Virtual Try-On: True
    Outfit Recommendation: Yes
