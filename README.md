# FinAI

A Flutter-based mobile application that helps users discover personalized employee benefit plans through intelligent lifestyle analysis.

## Overview

FinAI simplifies the process of selecting employee benefits by analyzing user lifestyle and providing tailored recommendations. The app uses two primary methods to understand user needs:

1. **Form-based questionnaire** - Users answer questions about their health, lifestyle, family, and budget preferences
2. **Instagram analysis** - AI-powered analysis of user Instagram posts to detect lifestyle patterns and activities

## Features

- User authentication via AWS Amplify Cognito
- Interactive benefit questionnaire with dynamic question flow
- Instagram lifestyle analysis using machine learning
- AI chat assistant for benefit-related questions
- Personalized benefit plan recommendations
- Current plan overview with coverage details
- Session-based conversation management

## Architecture

The app integrates with backend services hosted on AWS and Google Cloud Platform for:
- Instagram post analysis
- LLM-powered chat assistance
- User benefit plan generation

## Technology Stack

- Flutter/Dart
- AWS Amplify (Authentication)
- Google Cloud Run (Chat API)
- AWS Lambda (Instagram Analysis API)