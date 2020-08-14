import kfserving
import os
from typing import Dict
import torch
import importlib
import sys
import pickle

MODEL_FILE = "model.pkl"

class InferenceModel(kfserving.KFModel):
    def __init__(self, name: str, model_class_name: str, model_dir: str):
        super().__init__(name)
        self.name = name
        self.model_class_name = model_class_name
        self.model_dir = model_dir
        self.ready = False

    def load(self):
        model_file_dir = kfserving.Storage.download(self.model_dir)
        model_file = os.path.join(model_file_dir, MODEL_FILE)
        with open(model_file, "rb") as f:
            self.model = pickle.load(f)
        self.ready = True

    def predict(self, data):
        try:
            result = self.model.predict(data)
            return result
        except Exception as e:
            raise Exception("Failed to predict %s" % e)