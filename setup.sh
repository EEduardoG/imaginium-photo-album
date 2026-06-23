#!/bin/bash
# =============================================================================
# Imaginium Photo Album — Setup Script
# Downloads the SSD MobileNet v2 model and TFLite native library.
#
# Usage: bash setup.sh
# =============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ASSETS_DIR="$SCRIPT_DIR/assets/models"
BLOBS_DIR="$SCRIPT_DIR/linux/blobs"

echo "============================================"
echo " Imaginium Photo Album — Setup"
echo "============================================"
echo ""

# ---------------------------------------------------------------------------
# 1. TensorFlow Lite native library (.so)
# ---------------------------------------------------------------------------
echo "[1/2] TensorFlow Lite native library..."

if [ -f "$BLOBS_DIR/libtensorflowlite_c-linux.so" ]; then
    echo "  ✓ Already present"
else
    echo "  Installing libtensorflow-lite-dev via apt..."
    sudo apt install -y libtensorflow-lite-dev 2>/dev/null || {
        echo "  ⚠ apt install failed. Please install manually:"
        echo "     sudo apt install libtensorflow-lite-dev"
        echo "     cp /usr/lib/x86_64-linux-gnu/libtensorflow-lite.so $BLOBS_DIR/libtensorflowlite_c-linux.so"
        exit 1
    }
    cp /usr/lib/x86_64-linux-gnu/libtensorflow-lite.so \
       "$BLOBS_DIR/libtensorflowlite_c-linux.so" 2>/dev/null
    if [ -f "$BLOBS_DIR/libtensorflowlite_c-linux.so" ]; then
        echo "  ✓ Installed"
    else
        echo "  ⚠ Could not copy. Find libtensorflow-lite.so and copy manually."
    fi
fi

# ---------------------------------------------------------------------------
# 2. SSD MobileNet v2 model
# ---------------------------------------------------------------------------
echo "[2/2] SSD MobileNet v2 model..."

if [ -f "$ASSETS_DIR/ssd_mobilenet_v2.tflite" ]; then
    echo "  ✓ Already present"
else
    echo "  Downloading from Google Coral test data..."
    wget -q -O "$ASSETS_DIR/ssd_mobilenet_v2.tflite" \
        "https://raw.githubusercontent.com/google-coral/test_data/master/ssd_mobilenet_v2_coco_quant_postprocess.tflite" 2>/dev/null || {
        echo "  ⚠ Download failed. Download manually from:"
        echo "     https://raw.githubusercontent.com/google-coral/test_data/master/ssd_mobilenet_v2_coco_quant_postprocess.tflite"
        echo "     Save as: $ASSETS_DIR/ssd_mobilenet_v2.tflite"
    }
    if [ -f "$ASSETS_DIR/ssd_mobilenet_v2.tflite" ]; then
        echo "  ✓ Downloaded"
    fi
fi

echo ""
echo "============================================"
echo " Setup complete!"
echo "============================================"
echo ""
echo "Next: flutter clean && flutter run"
echo ""
