(**************************************************************************)
(*  This unit is part of the Python for Delphi (P4D) library              *)
(*  Project home: https://github.com/pyscripter/python4delphi             *)
(*                                                                        *)
(*  Project Maintainer:  PyScripter (pyscripter@gmail.com)                *)
(*  Original Authors:    Dr. Dietmar Budelsky (dbudelsky@web.de)          *)
(*                       Morgan Martinet (https://github.com/mmm-experts) *)
(*  Core developer:      Lucas Belo (lucas.belo@live.com)                 *)
(*  Core developer:      fansxs (admin@glsite.com)                        *)
(*  Contributors:        See contributors.md at project home              *)
(*                                                                        *)
(*  LICENCE and Copyright: MIT (see project home)                         *)
(**************************************************************************)

{$I ..\Definition.Inc}

unit WrapMakerAi;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses,
  uMakerAi.Core, uMakerAi.MCPServer.Core,
  System.JSON, uMakerAi.Embeddings, uMakerAi.Embeddings.core,
  uMakerAi.Chat.AiConnection, uMakerAi.Chat.Messages, uMakerAi.Chat.Tools,
  uMakerAi.Memory.Types, uMakerAi.Memory, uMakerAi.Ollama.Vision,
  uMakerAi.OpenAI.Audio.Tool, uMakerAi.OpenAI.WebSearch,
  uMakerAi.RAG.Vector.Driver.MSSQL, uMakerAi.RAG.Vector.Driver.BinFile,
  uMakerAi.RAG.Vector.Driver.SQLite, uMakerAi.RAG.Vectors,
  uMakerAi.RAG.Vector.Driver.Postgres, uMakerAi.RAG.Graph.Core,
  uMakerAi.RAG.Graph.Driver.Postgres, uMakerAi.Realtime.MakerAi,
  uMakerAi.Realtime.Grok, uMakerAi.Tools.Functions, uMakerAi.Telemetry,
  uMakerAi.tools.ComputerUse, uMakerAi.Tools.TextEditor, uMakerAi.Tools.Shell,
  uMakerAi.Guardrails, uMakerAi.Realtime.Gemini, uMakerAi.Realtime,
  uMakerAi.Realtime.OpenAI, uMakerAi.ElevenLabs.Speech, uMakerAi.Gemini.Speech,
  uMakerAi.Ollama.Ocr, uMakerAi.Whisper, uMakerAi.OpenAI.Audio,
  uMakerAi.Gemini.WebSearch, uMakerAi.OpenAi.Dalle, uMakerAi.Gemini.Veo,
  uMakerAi.Chat.Gemini, uMakerAi.Gemini.Video, uMakerAi.Embeddings.Generic,
  uMakerAi.Embeddings.LMStudio, uMakerAi.Embeddings.Cohere,
  uMakerAi.Embeddings.Mistral, uMakerAi.Embeddings.Ollama,
  uMakerAi.Embeddings.Gemini, uMakerAi.Embeddings.OpenAi,
  uMakerAi.Embeddings.Connection, uMakerAi.Chat.MakerAi,
  uMakerAi.Chat.GenericLLM, uMakerAi.Chat.LMStudio, uMakerAi.Chat.Cohere,
  uMakerAi.Chat.Mistral, uMakerAi.Chat.Grok, uMakerAi.Chat.Kimi,
  uMakerAi.Chat.GLM, uMakerAi.Chat.DeepSeek, uMakerAi.Chat.Groq,
  uMakerAi.Chat.Ollama, uMakerAi.Chat.Claude, uMakerAi.Chat,
  uMakerAi.Chat.OpenAi, uMakerAi.Chat.Bridge, UMakerAi.MCPServer.SSE,
  uMakerAi.Utils.AudioPlayback, uMakerAi.Utils.AudioCapture,
  uMakerAi.Agents.Node.LLM, uMakerAi.Agents, uMakerAi.RAG.Graph.Documents,
  uMakerAi.RAG.Graph.Builder, uMakerAi.Utils.VoiceMonitor,
  UMakerAi.MCPServer.Direct, UMakerAi.MCPServer.Stdio, UMakerAi.MCPServer.Http,
  uMakerAi.Prompts, uMakerAi.Evals, uMakerAi.A2A.Client, uMakerAi.A2A.Server;

type
  TPyDelphiAiA2AServer = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiA2AServer;
    procedure SetDelphiObject(const Value: TAiA2AServer);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiA2AServer read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiA2AClient = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiA2AClient;
    procedure SetDelphiObject(const Value: TAiA2AClient);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiA2AClient read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiA2AAgentTool = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiA2AAgentTool;
    procedure SetDelphiObject(const Value: TAiA2AAgentTool);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiA2AAgentTool read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiEvalRunner = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiEvalRunner;
    procedure SetDelphiObject(const Value: TAiEvalRunner);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiEvalRunner read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiPrompts = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiPrompts;
    procedure SetDelphiObject(const Value: TAiPrompts);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiPrompts read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiMCPHttpServer = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiMCPHttpServer;
    procedure SetDelphiObject(const Value: TAiMCPHttpServer);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiMCPHttpServer read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiMCPStdioServer = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiMCPStdioServer;
    procedure SetDelphiObject(const Value: TAiMCPStdioServer);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiMCPStdioServer read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiMCPDirectConnection = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiMCPDirectConnection;
    procedure SetDelphiObject(const Value: TAiMCPDirectConnection);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiMCPDirectConnection read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAIVoiceMonitor = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAIVoiceMonitor;
    procedure SetDelphiObject(const Value: TAIVoiceMonitor);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAIVoiceMonitor read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiRagGraphBuilder = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiRagGraphBuilder;
    procedure SetDelphiObject(const Value: TAiRagGraphBuilder);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiRagGraphBuilder read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiRagDocumentManager = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiRagDocumentManager;
    procedure SetDelphiObject(const Value: TAiRagDocumentManager);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiRagDocumentManager read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAIAgentManager = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAIAgentManager;
    procedure SetDelphiObject(const Value: TAIAgentManager);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAIAgentManager read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAIAgentsNode = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAIAgentsNode;
    procedure SetDelphiObject(const Value: TAIAgentsNode);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAIAgentsNode read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAIAgentsLink = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAIAgentsLink;
    procedure SetDelphiObject(const Value: TAIAgentsLink);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAIAgentsLink read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiAgentsToolSample = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiAgentsToolSample;
    procedure SetDelphiObject(const Value: TAiAgentsToolSample);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiAgentsToolSample read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAIAgents = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAIAgents;
    procedure SetDelphiObject(const Value: TAIAgents);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAIAgents read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiChatConnection = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiChatConnection;
    procedure SetDelphiObject(const Value: TAiChatConnection);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiChatConnection read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiLLMNode = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TLLMNode;
    procedure SetDelphiObject(const Value: TLLMNode);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TLLMNode read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiAudioCapture = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiAudioCapture;
    procedure SetDelphiObject(const Value: TAiAudioCapture);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiAudioCapture read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiAudioPlayer = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiAudioPlayer;
    procedure SetDelphiObject(const Value: TAiAudioPlayer);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiAudioPlayer read GetDelphiObject
      write SetDelphiObject;
  end;

//  TPyDelphiAiMCPSSEHttpServer = class(TPyDelphiComponent)
//  private
//    function GetDelphiObject: TAiMCPSSEHttpServer;
//    procedure SetDelphiObject(const Value: TAiMCPSSEHttpServer);
//  public
//    class function DelphiObjectClass: TClass; override;
//    // Properties
//    property DelphiObject: TAiMCPSSEHttpServer read GetDelphiObject
//      write SetDelphiObject;
//  end;

  TPyDelphiAiChatSpeechBridge = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiChatSpeechBridge;
    procedure SetDelphiObject(const Value: TAiChatSpeechBridge);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiChatSpeechBridge read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiChatVisionBridge = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiChatVisionBridge;
    procedure SetDelphiObject(const Value: TAiChatVisionBridge);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiChatVisionBridge read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiChatImageBridge = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiChatImageBridge;
    procedure SetDelphiObject(const Value: TAiChatImageBridge);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiChatImageBridge read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiChatVideoBridge = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiChatVideoBridge;
    procedure SetDelphiObject(const Value: TAiChatVideoBridge);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiChatVideoBridge read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiChatDocumentBridge = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiChatDocumentBridge;
    procedure SetDelphiObject(const Value: TAiChatDocumentBridge);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiChatDocumentBridge read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiChatCodeInterpreterBridge = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiChatCodeInterpreterBridge;
    procedure SetDelphiObject(const Value: TAiChatCodeInterpreterBridge);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiChatCodeInterpreterBridge read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiChatWebSearchBridge = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiChatWebSearchBridge;
    procedure SetDelphiObject(const Value: TAiChatWebSearchBridge);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiChatWebSearchBridge read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiRAGVector = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiRAGVector;
    procedure SetDelphiObject(const Value: TAiRAGVector);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiRAGVector read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiRagGraph = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiRagGraph;
    procedure SetDelphiObject(const Value: TAiRagGraph);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiRagGraph read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiOpenChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiOpenChat;
    procedure SetDelphiObject(const Value: TAiOpenChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiOpenChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiClaudeChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiClaudeChat;
    procedure SetDelphiObject(const Value: TAiClaudeChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiClaudeChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiOllamaChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiOllamaChat;
    procedure SetDelphiObject(const Value: TAiOllamaChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiOllamaChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGroqChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGroqChat;
    procedure SetDelphiObject(const Value: TAiGroqChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGroqChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiDeepSeekChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiDeepSeekChat;
    procedure SetDelphiObject(const Value: TAiDeepSeekChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiDeepSeekChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGLMChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGLMChat;
    procedure SetDelphiObject(const Value: TAiGLMChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGLMChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiKimiChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiKimiChat;
    procedure SetDelphiObject(const Value: TAiKimiChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiKimiChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGrokChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGrokChat;
    procedure SetDelphiObject(const Value: TAiGrokChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGrokChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiMistralChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiMistralChat;
    procedure SetDelphiObject(const Value: TAiMistralChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiMistralChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiCohereChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TCohereChat;
    procedure SetDelphiObject(const Value: TCohereChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TCohereChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiLMStudioChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiLMStudioChat;
    procedure SetDelphiObject(const Value: TAiLMStudioChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiLMStudioChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGenericChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGenericChat;
    procedure SetDelphiObject(const Value: TAiGenericChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGenericChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiMakerAiChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiMakerAiChat;
    procedure SetDelphiObject(const Value: TAiMakerAiChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiMakerAiChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiEmbeddingConnection = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiEmbeddingConnection;
    procedure SetDelphiObject(const Value: TAiEmbeddingConnection);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiEmbeddingConnection read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiOpenAiEmbeddings = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiOpenAiEmbeddings;
    procedure SetDelphiObject(const Value: TAiOpenAiEmbeddings);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiOpenAiEmbeddings read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGeminiEmbeddings = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGeminiEmbeddings;
    procedure SetDelphiObject(const Value: TAiGeminiEmbeddings);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGeminiEmbeddings read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiOllamaEmbeddings = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiOllamaEmbeddings;
    procedure SetDelphiObject(const Value: TAiOllamaEmbeddings);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiOllamaEmbeddings read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiMistralEmbeddings = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiMistralEmbeddings;
    procedure SetDelphiObject(const Value: TAiMistralEmbeddings);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiMistralEmbeddings read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiCohereEmbeddings = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiCohereEmbeddings;
    procedure SetDelphiObject(const Value: TAiCohereEmbeddings);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiCohereEmbeddings read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiLMStudioEmbeddings = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiLMStudioEmbeddings;
    procedure SetDelphiObject(const Value: TAiLMStudioEmbeddings);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiLMStudioEmbeddings read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGenericEmbeddings = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGenericEmbeddings;
    procedure SetDelphiObject(const Value: TAiGenericEmbeddings);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGenericEmbeddings read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGeminiVideoTool = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGeminiVideoTool;
    procedure SetDelphiObject(const Value: TAiGeminiVideoTool);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGeminiVideoTool read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGeminiChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGeminiChat;
    procedure SetDelphiObject(const Value: TAiGeminiChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGeminiChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiVeoGenerator = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiVeoGenerator;
    procedure SetDelphiObject(const Value: TAiVeoGenerator);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiVeoGenerator read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiDalle = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiDalle;
    procedure SetDelphiObject(const Value: TAiDalle);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiDalle read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiDalleImageTool = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiDalleImageTool;
    procedure SetDelphiObject(const Value: TAiDalleImageTool);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiDalleImageTool read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGeminiWebSearchTool = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGeminiWebSearchTool;
    procedure SetDelphiObject(const Value: TAiGeminiWebSearchTool);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGeminiWebSearchTool read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiOpenAiAudio = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiOpenAiAudio;
    procedure SetDelphiObject(const Value: TAiOpenAiAudio);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiOpenAiAudio read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAIWhisper = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAIWhisper;
    procedure SetDelphiObject(const Value: TAIWhisper);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAIWhisper read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiOllamaOcrTool = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiOllamaOcrTool;
    procedure SetDelphiObject(const Value: TAiOllamaOcrTool);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiOllamaOcrTool read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGeminiSpeechTool = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGeminiSpeechTool;
    procedure SetDelphiObject(const Value: TAiGeminiSpeechTool);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGeminiSpeechTool read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiElevenLabsSpeechTool = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiElevenLabsSpeechTool;
    procedure SetDelphiObject(const Value: TAiElevenLabsSpeechTool);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiElevenLabsSpeechTool read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiOpenAiRealtimeSTT = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiOpenAiRealtimeSTT;
    procedure SetDelphiObject(const Value: TAiOpenAiRealtimeSTT);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiOpenAiRealtimeSTT read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiOpenAiRealtimeTranslate = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiOpenAiRealtimeTranslate;
    procedure SetDelphiObject(const Value: TAiOpenAiRealtimeTranslate);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiOpenAiRealtimeTranslate read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGeminiRealtimeSTT = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGeminiRealtimeSTT;
    procedure SetDelphiObject(const Value: TAiGeminiRealtimeSTT);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGeminiRealtimeSTT read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGuardrails = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGuardrails;
    procedure SetDelphiObject(const Value: TAiGuardrails);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGuardrails read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiShell = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiShell;
    procedure SetDelphiObject(const Value: TAiShell);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiShell read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiTextEditorTool = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiTextEditorTool;
    procedure SetDelphiObject(const Value: TAiTextEditorTool);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiTextEditorTool read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiComputerUseTool = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiComputerUseTool;
    procedure SetDelphiObject(const Value: TAiComputerUseTool);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiComputerUseTool read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiTelemetry = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiTelemetry;
    procedure SetDelphiObject(const Value: TAiTelemetry);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiTelemetry read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiFunctions = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiFunctions;
    procedure SetDelphiObject(const Value: TAiFunctions);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiFunctions read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiGrokRealtimeChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiGrokRealtimeChat;
    procedure SetDelphiObject(const Value: TAiGrokRealtimeChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiGrokRealtimeChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiMakerAiRealtimeChat = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiMakerAiRealtimeChat;
    procedure SetDelphiObject(const Value: TAiMakerAiRealtimeChat);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiMakerAiRealtimeChat read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiRagGraphPostgresDriver = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiRagGraphPostgresDriver;
    procedure SetDelphiObject(const Value: TAiRagGraphPostgresDriver);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiRagGraphPostgresDriver read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiRAGVectorPostgresDriver = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiRAGVectorPostgresDriver;
    procedure SetDelphiObject(const Value: TAiRAGVectorPostgresDriver);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiRAGVectorPostgresDriver read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiRAGVectorSQLiteDriver = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiRAGVectorSQLiteDriver;
    procedure SetDelphiObject(const Value: TAiRAGVectorSQLiteDriver);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiRAGVectorSQLiteDriver read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiMkVecDriver = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiMkVecDriver;
    procedure SetDelphiObject(const Value: TAiMkVecDriver);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiMkVecDriver read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiRAGVectorMSSQLDriver = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiRAGVectorMSSQLDriver;
    procedure SetDelphiObject(const Value: TAiRAGVectorMSSQLDriver);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiRAGVectorMSSQLDriver read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiOpenAiWebSearchTool = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiOpenAiWebSearchTool;
    procedure SetDelphiObject(const Value: TAiOpenAiWebSearchTool);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiOpenAiWebSearchTool read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiOpenAiSpeechTool = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiOpenAiSpeechTool;
    procedure SetDelphiObject(const Value: TAiOpenAiSpeechTool);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiOpenAiSpeechTool read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiOllamaVisionTool = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiOllamaVisionTool;
    procedure SetDelphiObject(const Value: TAiOllamaVisionTool);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiOllamaVisionTool read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiAiMemory = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiMemory;
    procedure SetDelphiObject(const Value: TAiMemory);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiMemory read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TMakerAiRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

{ TMakerAiRegistration }
procedure TMakerAiRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TMakerAiRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

function TMakerAiRegistration.Name: string;
begin
  Result := 'MakerAI';
end;

procedure TMakerAiRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiA2AServer);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiA2AClient);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiA2AAgentTool);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiEvalRunner);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiPrompts);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMCPHttpServer);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMCPStdioServer);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMCPDirectConnection);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAIVoiceMonitor);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiRagGraphBuilder);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiRagDocumentManager);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAIAgentManager);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAIAgentsNode);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAIAgentsLink);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiAgentsToolSample);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAIAgents);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiChatConnection);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiLLMNode);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiAudioCapture);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiAudioPlayer);
//  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMCPSSEHttpServer);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiChatSpeechBridge);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiChatVisionBridge);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiChatImageBridge);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiChatVideoBridge);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiChatDocumentBridge);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiChatCodeInterpreterBridge);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiChatWebSearchBridge);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiRAGVector);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiRagGraph);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOpenChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiClaudeChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOllamaChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGroqChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiDeepSeekChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGLMChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiKimiChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGrokChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMistralChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCohereChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiLMStudioChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGenericChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMakerAiChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiEmbeddingConnection);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOpenAiEmbeddings);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGeminiEmbeddings);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOllamaEmbeddings);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMistralEmbeddings);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiCohereEmbeddings);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiLMStudioEmbeddings);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGenericEmbeddings);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGeminiVideoTool);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGeminiChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiVeoGenerator);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiDalle);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiDalleImageTool);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGeminiWebSearchTool);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOpenAiAudio);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAIWhisper);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOllamaOcrTool);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGeminiSpeechTool);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiElevenLabsSpeechTool);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOpenAiRealtimeSTT);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOpenAiRealtimeTranslate);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGeminiRealtimeSTT);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGuardrails);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiShell);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiTextEditorTool);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiComputerUseTool);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiTelemetry);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiFunctions);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGrokRealtimeChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMakerAiRealtimeChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiRagGraphPostgresDriver);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiRAGVectorPostgresDriver);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiRAGVectorSQLiteDriver);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMkVecDriver);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiRAGVectorMSSQLDriver);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOpenAiWebSearchTool);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOpenAiSpeechTool);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOllamaVisionTool);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMemory);
end;

{ TPyDelphiAiA2AServer }

class function TPyDelphiAiA2AServer.DelphiObjectClass: TClass;
begin
  Result := TAiA2AServer;
end;

function TPyDelphiAiA2AServer.GetDelphiObject: TAiA2AServer;
begin
  Result := TAiA2AServer(inherited DelphiObject);
end;

procedure TPyDelphiAiA2AServer.SetDelphiObject(const Value: TAiA2AServer);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiA2AClient }

class function TPyDelphiAiA2AClient.DelphiObjectClass: TClass;
begin
  Result := TAiA2AClient;
end;

function TPyDelphiAiA2AClient.GetDelphiObject: TAiA2AClient;
begin
  Result := TAiA2AClient(inherited DelphiObject);
end;

procedure TPyDelphiAiA2AClient.SetDelphiObject(const Value: TAiA2AClient);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiA2AAgentTool }

class function TPyDelphiAiA2AAgentTool.DelphiObjectClass: TClass;
begin
  Result := TAiA2AAgentTool;
end;

function TPyDelphiAiA2AAgentTool.GetDelphiObject: TAiA2AAgentTool;
begin
  Result := TAiA2AAgentTool(inherited DelphiObject);
end;

procedure TPyDelphiAiA2AAgentTool.SetDelphiObject(const Value: TAiA2AAgentTool);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiEvalRunner }

class function TPyDelphiAiEvalRunner.DelphiObjectClass: TClass;
begin
  Result := TAiEvalRunner;
end;

function TPyDelphiAiEvalRunner.GetDelphiObject: TAiEvalRunner;
begin
  Result := TAiEvalRunner(inherited DelphiObject);
end;

procedure TPyDelphiAiEvalRunner.SetDelphiObject(const Value: TAiEvalRunner);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiPrompts }

class function TPyDelphiAiPrompts.DelphiObjectClass: TClass;
begin
  Result := TAiPrompts;
end;

function TPyDelphiAiPrompts.GetDelphiObject: TAiPrompts;
begin
  Result := TAiPrompts(inherited DelphiObject);
end;

procedure TPyDelphiAiPrompts.SetDelphiObject(const Value: TAiPrompts);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiMCPHttpServer }

class function TPyDelphiAiMCPHttpServer.DelphiObjectClass: TClass;
begin
  Result := TAiMCPHttpServer;
end;

function TPyDelphiAiMCPHttpServer.GetDelphiObject: TAiMCPHttpServer;
begin
  Result := TAiMCPHttpServer(inherited DelphiObject);
end;

procedure TPyDelphiAiMCPHttpServer.SetDelphiObject(const Value: TAiMCPHttpServer);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiMCPStdioServer }

class function TPyDelphiAiMCPStdioServer.DelphiObjectClass: TClass;
begin
  Result := TAiMCPStdioServer;
end;

function TPyDelphiAiMCPStdioServer.GetDelphiObject: TAiMCPStdioServer;
begin
  Result := TAiMCPStdioServer(inherited DelphiObject);
end;

procedure TPyDelphiAiMCPStdioServer.SetDelphiObject(const Value: TAiMCPStdioServer);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiMCPDirectConnection }

class function TPyDelphiAiMCPDirectConnection.DelphiObjectClass: TClass;
begin
  Result := TAiMCPDirectConnection;
end;

function TPyDelphiAiMCPDirectConnection.GetDelphiObject: TAiMCPDirectConnection;
begin
  Result := TAiMCPDirectConnection(inherited DelphiObject);
end;

procedure TPyDelphiAiMCPDirectConnection.SetDelphiObject(const Value: TAiMCPDirectConnection);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAIVoiceMonitor }

class function TPyDelphiAIVoiceMonitor.DelphiObjectClass: TClass;
begin
  Result := TAIVoiceMonitor;
end;

function TPyDelphiAIVoiceMonitor.GetDelphiObject: TAIVoiceMonitor;
begin
  Result := TAIVoiceMonitor(inherited DelphiObject);
end;

procedure TPyDelphiAIVoiceMonitor.SetDelphiObject(const Value: TAIVoiceMonitor);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiRagGraphBuilder }

class function TPyDelphiAiRagGraphBuilder.DelphiObjectClass: TClass;
begin
  Result := TAiRagGraphBuilder;
end;

function TPyDelphiAiRagGraphBuilder.GetDelphiObject: TAiRagGraphBuilder;
begin
  Result := TAiRagGraphBuilder(inherited DelphiObject);
end;

procedure TPyDelphiAiRagGraphBuilder.SetDelphiObject(const Value: TAiRagGraphBuilder);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiRagDocumentManager }

class function TPyDelphiAiRagDocumentManager.DelphiObjectClass: TClass;
begin
  Result := TAiRagDocumentManager;
end;

function TPyDelphiAiRagDocumentManager.GetDelphiObject: TAiRagDocumentManager;
begin
  Result := TAiRagDocumentManager(inherited DelphiObject);
end;

procedure TPyDelphiAiRagDocumentManager.SetDelphiObject(const Value: TAiRagDocumentManager);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAIAgentManager }

class function TPyDelphiAIAgentManager.DelphiObjectClass: TClass;
begin
  Result := TAIAgentManager;
end;

function TPyDelphiAIAgentManager.GetDelphiObject: TAIAgentManager;
begin
  Result := TAIAgentManager(inherited DelphiObject);
end;

procedure TPyDelphiAIAgentManager.SetDelphiObject(const Value: TAIAgentManager);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAIAgentsNode }

class function TPyDelphiAIAgentsNode.DelphiObjectClass: TClass;
begin
  Result := TAIAgentsNode;
end;

function TPyDelphiAIAgentsNode.GetDelphiObject: TAIAgentsNode;
begin
  Result := TAIAgentsNode(inherited DelphiObject);
end;

procedure TPyDelphiAIAgentsNode.SetDelphiObject(const Value: TAIAgentsNode);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAIAgentsLink }

class function TPyDelphiAIAgentsLink.DelphiObjectClass: TClass;
begin
  Result := TAIAgentsLink;
end;

function TPyDelphiAIAgentsLink.GetDelphiObject: TAIAgentsLink;
begin
  Result := TAIAgentsLink(inherited DelphiObject);
end;

procedure TPyDelphiAIAgentsLink.SetDelphiObject(const Value: TAIAgentsLink);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiAgentsToolSample }

class function TPyDelphiAiAgentsToolSample.DelphiObjectClass: TClass;
begin
  Result := TAiAgentsToolSample;
end;

function TPyDelphiAiAgentsToolSample.GetDelphiObject: TAiAgentsToolSample;
begin
  Result := TAiAgentsToolSample(inherited DelphiObject);
end;

procedure TPyDelphiAiAgentsToolSample.SetDelphiObject(const Value: TAiAgentsToolSample);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAIAgents }

class function TPyDelphiAIAgents.DelphiObjectClass: TClass;
begin
  Result := TAIAgents;
end;

function TPyDelphiAIAgents.GetDelphiObject: TAIAgents;
begin
  Result := TAIAgents(inherited DelphiObject);
end;

procedure TPyDelphiAIAgents.SetDelphiObject(const Value: TAIAgents);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiChatConnection }

class function TPyDelphiAiChatConnection.DelphiObjectClass: TClass;
begin
  Result := TAiChatConnection;
end;

function TPyDelphiAiChatConnection.GetDelphiObject: TAiChatConnection;
begin
  Result := TAiChatConnection(inherited DelphiObject);
end;

procedure TPyDelphiAiChatConnection.SetDelphiObject(const Value: TAiChatConnection);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiLLMNode }

class function TPyDelphiLLMNode.DelphiObjectClass: TClass;
begin
  Result := TLLMNode;
end;

function TPyDelphiLLMNode.GetDelphiObject: TLLMNode;
begin
  Result := TLLMNode(inherited DelphiObject);
end;

procedure TPyDelphiLLMNode.SetDelphiObject(const Value: TLLMNode);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiAudioCapture }

class function TPyDelphiAiAudioCapture.DelphiObjectClass: TClass;
begin
  Result := TAiAudioCapture;
end;

function TPyDelphiAiAudioCapture.GetDelphiObject: TAiAudioCapture;
begin
  Result := TAiAudioCapture(inherited DelphiObject);
end;

procedure TPyDelphiAiAudioCapture.SetDelphiObject(const Value: TAiAudioCapture);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiAudioPlayer }

class function TPyDelphiAiAudioPlayer.DelphiObjectClass: TClass;
begin
  Result := TAiAudioPlayer;
end;

function TPyDelphiAiAudioPlayer.GetDelphiObject: TAiAudioPlayer;
begin
  Result := TAiAudioPlayer(inherited DelphiObject);
end;

procedure TPyDelphiAiAudioPlayer.SetDelphiObject(const Value: TAiAudioPlayer);
begin
  inherited DelphiObject := Value;
end;

//{ TPyDelphiAiMCPSSEHttpServer }
//
//class function TPyDelphiAiMCPSSEHttpServer.DelphiObjectClass: TClass;
//begin
//  Result := TAiMCPSSEHttpServer;
//end;
//
//function TPyDelphiAiMCPSSEHttpServer.GetDelphiObject: TAiMCPSSEHttpServer;
//begin
//  Result := TAiMCPSSEHttpServer(inherited DelphiObject);
//end;
//
//procedure TPyDelphiAiMCPSSEHttpServer.SetDelphiObject(const Value: TAiMCPSSEHttpServer);
//begin
//  inherited DelphiObject := Value;
//end;

{ TPyDelphiAiChatSpeechBridge }

class function TPyDelphiAiChatSpeechBridge.DelphiObjectClass: TClass;
begin
  Result := TAiChatSpeechBridge;
end;

function TPyDelphiAiChatSpeechBridge.GetDelphiObject: TAiChatSpeechBridge;
begin
  Result := TAiChatSpeechBridge(inherited DelphiObject);
end;

procedure TPyDelphiAiChatSpeechBridge.SetDelphiObject(const Value: TAiChatSpeechBridge);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiChatVisionBridge }

class function TPyDelphiAiChatVisionBridge.DelphiObjectClass: TClass;
begin
  Result := TAiChatVisionBridge;
end;

function TPyDelphiAiChatVisionBridge.GetDelphiObject: TAiChatVisionBridge;
begin
  Result := TAiChatVisionBridge(inherited DelphiObject);
end;

procedure TPyDelphiAiChatVisionBridge.SetDelphiObject(const Value: TAiChatVisionBridge);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiChatImageBridge }

class function TPyDelphiAiChatImageBridge.DelphiObjectClass: TClass;
begin
  Result := TAiChatImageBridge;
end;

function TPyDelphiAiChatImageBridge.GetDelphiObject: TAiChatImageBridge;
begin
  Result := TAiChatImageBridge(inherited DelphiObject);
end;

procedure TPyDelphiAiChatImageBridge.SetDelphiObject(const Value: TAiChatImageBridge);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiChatVideoBridge }

class function TPyDelphiAiChatVideoBridge.DelphiObjectClass: TClass;
begin
  Result := TAiChatVideoBridge;
end;

function TPyDelphiAiChatVideoBridge.GetDelphiObject: TAiChatVideoBridge;
begin
  Result := TAiChatVideoBridge(inherited DelphiObject);
end;

procedure TPyDelphiAiChatVideoBridge.SetDelphiObject(const Value: TAiChatVideoBridge);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiChatDocumentBridge }

class function TPyDelphiAiChatDocumentBridge.DelphiObjectClass: TClass;
begin
  Result := TAiChatDocumentBridge;
end;

function TPyDelphiAiChatDocumentBridge.GetDelphiObject: TAiChatDocumentBridge;
begin
  Result := TAiChatDocumentBridge(inherited DelphiObject);
end;

procedure TPyDelphiAiChatDocumentBridge.SetDelphiObject(const Value: TAiChatDocumentBridge);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiChatCodeInterpreterBridge }

class function TPyDelphiAiChatCodeInterpreterBridge.DelphiObjectClass: TClass;
begin
  Result := TAiChatCodeInterpreterBridge;
end;

function TPyDelphiAiChatCodeInterpreterBridge.GetDelphiObject: TAiChatCodeInterpreterBridge;
begin
  Result := TAiChatCodeInterpreterBridge(inherited DelphiObject);
end;

procedure TPyDelphiAiChatCodeInterpreterBridge.SetDelphiObject(const Value: TAiChatCodeInterpreterBridge);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiChatWebSearchBridge }

class function TPyDelphiAiChatWebSearchBridge.DelphiObjectClass: TClass;
begin
  Result := TAiChatWebSearchBridge;
end;

function TPyDelphiAiChatWebSearchBridge.GetDelphiObject: TAiChatWebSearchBridge;
begin
  Result := TAiChatWebSearchBridge(inherited DelphiObject);
end;

procedure TPyDelphiAiChatWebSearchBridge.SetDelphiObject(const Value: TAiChatWebSearchBridge);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiRAGVector }

class function TPyDelphiAiRAGVector.DelphiObjectClass: TClass;
begin
  Result := TAiRAGVector;
end;

function TPyDelphiAiRAGVector.GetDelphiObject: TAiRAGVector;
begin
  Result := TAiRAGVector(inherited DelphiObject);
end;

procedure TPyDelphiAiRAGVector.SetDelphiObject(const Value: TAiRAGVector);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiRagGraph }

class function TPyDelphiAiRagGraph.DelphiObjectClass: TClass;
begin
  Result := TAiRagGraph;
end;

function TPyDelphiAiRagGraph.GetDelphiObject: TAiRagGraph;
begin
  Result := TAiRagGraph(inherited DelphiObject);
end;

procedure TPyDelphiAiRagGraph.SetDelphiObject(const Value: TAiRagGraph);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiOpenChat }

class function TPyDelphiAiOpenChat.DelphiObjectClass: TClass;
begin
  Result := TAiOpenChat;
end;

function TPyDelphiAiOpenChat.GetDelphiObject: TAiOpenChat;
begin
  Result := TAiOpenChat(inherited DelphiObject);
end;

procedure TPyDelphiAiOpenChat.SetDelphiObject(const Value: TAiOpenChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiClaudeChat }

class function TPyDelphiAiClaudeChat.DelphiObjectClass: TClass;
begin
  Result := TAiClaudeChat;
end;

function TPyDelphiAiClaudeChat.GetDelphiObject: TAiClaudeChat;
begin
  Result := TAiClaudeChat(inherited DelphiObject);
end;

procedure TPyDelphiAiClaudeChat.SetDelphiObject(const Value: TAiClaudeChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiOllamaChat }

class function TPyDelphiAiOllamaChat.DelphiObjectClass: TClass;
begin
  Result := TAiOllamaChat;
end;

function TPyDelphiAiOllamaChat.GetDelphiObject: TAiOllamaChat;
begin
  Result := TAiOllamaChat(inherited DelphiObject);
end;

procedure TPyDelphiAiOllamaChat.SetDelphiObject(const Value: TAiOllamaChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGroqChat }

class function TPyDelphiAiGroqChat.DelphiObjectClass: TClass;
begin
  Result := TAiGroqChat;
end;

function TPyDelphiAiGroqChat.GetDelphiObject: TAiGroqChat;
begin
  Result := TAiGroqChat(inherited DelphiObject);
end;

procedure TPyDelphiAiGroqChat.SetDelphiObject(const Value: TAiGroqChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiDeepSeekChat }

class function TPyDelphiAiDeepSeekChat.DelphiObjectClass: TClass;
begin
  Result := TAiDeepSeekChat;
end;

function TPyDelphiAiDeepSeekChat.GetDelphiObject: TAiDeepSeekChat;
begin
  Result := TAiDeepSeekChat(inherited DelphiObject);
end;

procedure TPyDelphiAiDeepSeekChat.SetDelphiObject(const Value: TAiDeepSeekChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGLMChat }

class function TPyDelphiAiGLMChat.DelphiObjectClass: TClass;
begin
  Result := TAiGLMChat;
end;

function TPyDelphiAiGLMChat.GetDelphiObject: TAiGLMChat;
begin
  Result := TAiGLMChat(inherited DelphiObject);
end;

procedure TPyDelphiAiGLMChat.SetDelphiObject(const Value: TAiGLMChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiKimiChat }

class function TPyDelphiAiKimiChat.DelphiObjectClass: TClass;
begin
  Result := TAiKimiChat;
end;

function TPyDelphiAiKimiChat.GetDelphiObject: TAiKimiChat;
begin
  Result := TAiKimiChat(inherited DelphiObject);
end;

procedure TPyDelphiAiKimiChat.SetDelphiObject(const Value: TAiKimiChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGrokChat }

class function TPyDelphiAiGrokChat.DelphiObjectClass: TClass;
begin
  Result := TAiGrokChat;
end;

function TPyDelphiAiGrokChat.GetDelphiObject: TAiGrokChat;
begin
  Result := TAiGrokChat(inherited DelphiObject);
end;

procedure TPyDelphiAiGrokChat.SetDelphiObject(const Value: TAiGrokChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiMistralChat }

class function TPyDelphiAiMistralChat.DelphiObjectClass: TClass;
begin
  Result := TAiMistralChat;
end;

function TPyDelphiAiMistralChat.GetDelphiObject: TAiMistralChat;
begin
  Result := TAiMistralChat(inherited DelphiObject);
end;

procedure TPyDelphiAiMistralChat.SetDelphiObject(const Value: TAiMistralChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCohereChat }

class function TPyDelphiCohereChat.DelphiObjectClass: TClass;
begin
  Result := TCohereChat;
end;

function TPyDelphiCohereChat.GetDelphiObject: TCohereChat;
begin
  Result := TCohereChat(inherited DelphiObject);
end;

procedure TPyDelphiCohereChat.SetDelphiObject(const Value: TCohereChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiLMStudioChat }

class function TPyDelphiAiLMStudioChat.DelphiObjectClass: TClass;
begin
  Result := TAiLMStudioChat;
end;

function TPyDelphiAiLMStudioChat.GetDelphiObject: TAiLMStudioChat;
begin
  Result := TAiLMStudioChat(inherited DelphiObject);
end;

procedure TPyDelphiAiLMStudioChat.SetDelphiObject(const Value: TAiLMStudioChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGenericChat }

class function TPyDelphiAiGenericChat.DelphiObjectClass: TClass;
begin
  Result := TAiGenericChat;
end;

function TPyDelphiAiGenericChat.GetDelphiObject: TAiGenericChat;
begin
  Result := TAiGenericChat(inherited DelphiObject);
end;

procedure TPyDelphiAiGenericChat.SetDelphiObject(const Value: TAiGenericChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiMakerAiChat }

class function TPyDelphiAiMakerAiChat.DelphiObjectClass: TClass;
begin
  Result := TAiMakerAiChat;
end;

function TPyDelphiAiMakerAiChat.GetDelphiObject: TAiMakerAiChat;
begin
  Result := TAiMakerAiChat(inherited DelphiObject);
end;

procedure TPyDelphiAiMakerAiChat.SetDelphiObject(const Value: TAiMakerAiChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiEmbeddingConnection }

class function TPyDelphiAiEmbeddingConnection.DelphiObjectClass: TClass;
begin
  Result := TAiEmbeddingConnection;
end;

function TPyDelphiAiEmbeddingConnection.GetDelphiObject: TAiEmbeddingConnection;
begin
  Result := TAiEmbeddingConnection(inherited DelphiObject);
end;

procedure TPyDelphiAiEmbeddingConnection.SetDelphiObject(const Value: TAiEmbeddingConnection);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiOpenAiEmbeddings }

class function TPyDelphiAiOpenAiEmbeddings.DelphiObjectClass: TClass;
begin
  Result := TAiOpenAiEmbeddings;
end;

function TPyDelphiAiOpenAiEmbeddings.GetDelphiObject: TAiOpenAiEmbeddings;
begin
  Result := TAiOpenAiEmbeddings(inherited DelphiObject);
end;

procedure TPyDelphiAiOpenAiEmbeddings.SetDelphiObject(const Value: TAiOpenAiEmbeddings);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGeminiEmbeddings }

class function TPyDelphiAiGeminiEmbeddings.DelphiObjectClass: TClass;
begin
  Result := TAiGeminiEmbeddings;
end;

function TPyDelphiAiGeminiEmbeddings.GetDelphiObject: TAiGeminiEmbeddings;
begin
  Result := TAiGeminiEmbeddings(inherited DelphiObject);
end;

procedure TPyDelphiAiGeminiEmbeddings.SetDelphiObject(const Value: TAiGeminiEmbeddings);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiOllamaEmbeddings }

class function TPyDelphiAiOllamaEmbeddings.DelphiObjectClass: TClass;
begin
  Result := TAiOllamaEmbeddings;
end;

function TPyDelphiAiOllamaEmbeddings.GetDelphiObject: TAiOllamaEmbeddings;
begin
  Result := TAiOllamaEmbeddings(inherited DelphiObject);
end;

procedure TPyDelphiAiOllamaEmbeddings.SetDelphiObject(const Value: TAiOllamaEmbeddings);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiMistralEmbeddings }

class function TPyDelphiAiMistralEmbeddings.DelphiObjectClass: TClass;
begin
  Result := TAiMistralEmbeddings;
end;

function TPyDelphiAiMistralEmbeddings.GetDelphiObject: TAiMistralEmbeddings;
begin
  Result := TAiMistralEmbeddings(inherited DelphiObject);
end;

procedure TPyDelphiAiMistralEmbeddings.SetDelphiObject(const Value: TAiMistralEmbeddings);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiCohereEmbeddings }

class function TPyDelphiAiCohereEmbeddings.DelphiObjectClass: TClass;
begin
  Result := TAiCohereEmbeddings;
end;

function TPyDelphiAiCohereEmbeddings.GetDelphiObject: TAiCohereEmbeddings;
begin
  Result := TAiCohereEmbeddings(inherited DelphiObject);
end;

procedure TPyDelphiAiCohereEmbeddings.SetDelphiObject(const Value: TAiCohereEmbeddings);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiLMStudioEmbeddings }

class function TPyDelphiAiLMStudioEmbeddings.DelphiObjectClass: TClass;
begin
  Result := TAiLMStudioEmbeddings;
end;

function TPyDelphiAiLMStudioEmbeddings.GetDelphiObject: TAiLMStudioEmbeddings;
begin
  Result := TAiLMStudioEmbeddings(inherited DelphiObject);
end;

procedure TPyDelphiAiLMStudioEmbeddings.SetDelphiObject(const Value: TAiLMStudioEmbeddings);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGenericEmbeddings }

class function TPyDelphiAiGenericEmbeddings.DelphiObjectClass: TClass;
begin
  Result := TAiGenericEmbeddings;
end;

function TPyDelphiAiGenericEmbeddings.GetDelphiObject: TAiGenericEmbeddings;
begin
  Result := TAiGenericEmbeddings(inherited DelphiObject);
end;

procedure TPyDelphiAiGenericEmbeddings.SetDelphiObject(const Value: TAiGenericEmbeddings);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGeminiVideoTool }

class function TPyDelphiAiGeminiVideoTool.DelphiObjectClass: TClass;
begin
  Result := TAiGeminiVideoTool;
end;

function TPyDelphiAiGeminiVideoTool.GetDelphiObject: TAiGeminiVideoTool;
begin
  Result := TAiGeminiVideoTool(inherited DelphiObject);
end;

procedure TPyDelphiAiGeminiVideoTool.SetDelphiObject(const Value: TAiGeminiVideoTool);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGeminiChat }

class function TPyDelphiAiGeminiChat.DelphiObjectClass: TClass;
begin
  Result := TAiGeminiChat;
end;

function TPyDelphiAiGeminiChat.GetDelphiObject: TAiGeminiChat;
begin
  Result := TAiGeminiChat(inherited DelphiObject);
end;

procedure TPyDelphiAiGeminiChat.SetDelphiObject(const Value: TAiGeminiChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiVeoGenerator }

class function TPyDelphiAiVeoGenerator.DelphiObjectClass: TClass;
begin
  Result := TAiVeoGenerator;
end;

function TPyDelphiAiVeoGenerator.GetDelphiObject: TAiVeoGenerator;
begin
  Result := TAiVeoGenerator(inherited DelphiObject);
end;

procedure TPyDelphiAiVeoGenerator.SetDelphiObject(const Value: TAiVeoGenerator);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiDalle }

class function TPyDelphiAiDalle.DelphiObjectClass: TClass;
begin
  Result := TAiDalle;
end;

function TPyDelphiAiDalle.GetDelphiObject: TAiDalle;
begin
  Result := TAiDalle(inherited DelphiObject);
end;

procedure TPyDelphiAiDalle.SetDelphiObject(const Value: TAiDalle);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiDalleImageTool }

class function TPyDelphiAiDalleImageTool.DelphiObjectClass: TClass;
begin
  Result := TAiDalleImageTool;
end;

function TPyDelphiAiDalleImageTool.GetDelphiObject: TAiDalleImageTool;
begin
  Result := TAiDalleImageTool(inherited DelphiObject);
end;

procedure TPyDelphiAiDalleImageTool.SetDelphiObject(const Value: TAiDalleImageTool);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGeminiWebSearchTool }

class function TPyDelphiAiGeminiWebSearchTool.DelphiObjectClass: TClass;
begin
  Result := TAiGeminiWebSearchTool;
end;

function TPyDelphiAiGeminiWebSearchTool.GetDelphiObject: TAiGeminiWebSearchTool;
begin
  Result := TAiGeminiWebSearchTool(inherited DelphiObject);
end;

procedure TPyDelphiAiGeminiWebSearchTool.SetDelphiObject(const Value: TAiGeminiWebSearchTool);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiOpenAiAudio }

class function TPyDelphiAiOpenAiAudio.DelphiObjectClass: TClass;
begin
  Result := TAiOpenAiAudio;
end;

function TPyDelphiAiOpenAiAudio.GetDelphiObject: TAiOpenAiAudio;
begin
  Result := TAiOpenAiAudio(inherited DelphiObject);
end;

procedure TPyDelphiAiOpenAiAudio.SetDelphiObject(const Value: TAiOpenAiAudio);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAIWhisper }

class function TPyDelphiAIWhisper.DelphiObjectClass: TClass;
begin
  Result := TAIWhisper;
end;

function TPyDelphiAIWhisper.GetDelphiObject: TAIWhisper;
begin
  Result := TAIWhisper(inherited DelphiObject);
end;

procedure TPyDelphiAIWhisper.SetDelphiObject(const Value: TAIWhisper);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiOllamaOcrTool }

class function TPyDelphiAiOllamaOcrTool.DelphiObjectClass: TClass;
begin
  Result := TAiOllamaOcrTool;
end;

function TPyDelphiAiOllamaOcrTool.GetDelphiObject: TAiOllamaOcrTool;
begin
  Result := TAiOllamaOcrTool(inherited DelphiObject);
end;

procedure TPyDelphiAiOllamaOcrTool.SetDelphiObject(const Value: TAiOllamaOcrTool);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGeminiSpeechTool }

class function TPyDelphiAiGeminiSpeechTool.DelphiObjectClass: TClass;
begin
  Result := TAiGeminiSpeechTool;
end;

function TPyDelphiAiGeminiSpeechTool.GetDelphiObject: TAiGeminiSpeechTool;
begin
  Result := TAiGeminiSpeechTool(inherited DelphiObject);
end;

procedure TPyDelphiAiGeminiSpeechTool.SetDelphiObject(const Value: TAiGeminiSpeechTool);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiElevenLabsSpeechTool }

class function TPyDelphiAiElevenLabsSpeechTool.DelphiObjectClass: TClass;
begin
  Result := TAiElevenLabsSpeechTool;
end;

function TPyDelphiAiElevenLabsSpeechTool.GetDelphiObject: TAiElevenLabsSpeechTool;
begin
  Result := TAiElevenLabsSpeechTool(inherited DelphiObject);
end;

procedure TPyDelphiAiElevenLabsSpeechTool.SetDelphiObject(const Value: TAiElevenLabsSpeechTool);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiOpenAiRealtimeSTT }

class function TPyDelphiAiOpenAiRealtimeSTT.DelphiObjectClass: TClass;
begin
  Result := TAiOpenAiRealtimeSTT;
end;

function TPyDelphiAiOpenAiRealtimeSTT.GetDelphiObject: TAiOpenAiRealtimeSTT;
begin
  Result := TAiOpenAiRealtimeSTT(inherited DelphiObject);
end;

procedure TPyDelphiAiOpenAiRealtimeSTT.SetDelphiObject(const Value: TAiOpenAiRealtimeSTT);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiOpenAiRealtimeTranslate }

class function TPyDelphiAiOpenAiRealtimeTranslate.DelphiObjectClass: TClass;
begin
  Result := TAiOpenAiRealtimeTranslate;
end;

function TPyDelphiAiOpenAiRealtimeTranslate.GetDelphiObject: TAiOpenAiRealtimeTranslate;
begin
  Result := TAiOpenAiRealtimeTranslate(inherited DelphiObject);
end;

procedure TPyDelphiAiOpenAiRealtimeTranslate.SetDelphiObject(const Value: TAiOpenAiRealtimeTranslate);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGeminiRealtimeSTT }

class function TPyDelphiAiGeminiRealtimeSTT.DelphiObjectClass: TClass;
begin
  Result := TAiGeminiRealtimeSTT;
end;

function TPyDelphiAiGeminiRealtimeSTT.GetDelphiObject: TAiGeminiRealtimeSTT;
begin
  Result := TAiGeminiRealtimeSTT(inherited DelphiObject);
end;

procedure TPyDelphiAiGeminiRealtimeSTT.SetDelphiObject(const Value: TAiGeminiRealtimeSTT);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGuardrails }

class function TPyDelphiAiGuardrails.DelphiObjectClass: TClass;
begin
  Result := TAiGuardrails;
end;

function TPyDelphiAiGuardrails.GetDelphiObject: TAiGuardrails;
begin
  Result := TAiGuardrails(inherited DelphiObject);
end;

procedure TPyDelphiAiGuardrails.SetDelphiObject(const Value: TAiGuardrails);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiShell }

class function TPyDelphiAiShell.DelphiObjectClass: TClass;
begin
  Result := TAiShell;
end;

function TPyDelphiAiShell.GetDelphiObject: TAiShell;
begin
  Result := TAiShell(inherited DelphiObject);
end;

procedure TPyDelphiAiShell.SetDelphiObject(const Value: TAiShell);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiTextEditorTool }

class function TPyDelphiAiTextEditorTool.DelphiObjectClass: TClass;
begin
  Result := TAiTextEditorTool;
end;

function TPyDelphiAiTextEditorTool.GetDelphiObject: TAiTextEditorTool;
begin
  Result := TAiTextEditorTool(inherited DelphiObject);
end;

procedure TPyDelphiAiTextEditorTool.SetDelphiObject(const Value: TAiTextEditorTool);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiComputerUseTool }

class function TPyDelphiAiComputerUseTool.DelphiObjectClass: TClass;
begin
  Result := TAiComputerUseTool;
end;

function TPyDelphiAiComputerUseTool.GetDelphiObject: TAiComputerUseTool;
begin
  Result := TAiComputerUseTool(inherited DelphiObject);
end;

procedure TPyDelphiAiComputerUseTool.SetDelphiObject(const Value: TAiComputerUseTool);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiTelemetry }

class function TPyDelphiAiTelemetry.DelphiObjectClass: TClass;
begin
  Result := TAiTelemetry;
end;

function TPyDelphiAiTelemetry.GetDelphiObject: TAiTelemetry;
begin
  Result := TAiTelemetry(inherited DelphiObject);
end;

procedure TPyDelphiAiTelemetry.SetDelphiObject(const Value: TAiTelemetry);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiFunctions }

class function TPyDelphiAiFunctions.DelphiObjectClass: TClass;
begin
  Result := TAiFunctions;
end;

function TPyDelphiAiFunctions.GetDelphiObject: TAiFunctions;
begin
  Result := TAiFunctions(inherited DelphiObject);
end;

procedure TPyDelphiAiFunctions.SetDelphiObject(const Value: TAiFunctions);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiGrokRealtimeChat }

class function TPyDelphiAiGrokRealtimeChat.DelphiObjectClass: TClass;
begin
  Result := TAiGrokRealtimeChat;
end;

function TPyDelphiAiGrokRealtimeChat.GetDelphiObject: TAiGrokRealtimeChat;
begin
  Result := TAiGrokRealtimeChat(inherited DelphiObject);
end;

procedure TPyDelphiAiGrokRealtimeChat.SetDelphiObject(const Value: TAiGrokRealtimeChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiMakerAiRealtimeChat }

class function TPyDelphiAiMakerAiRealtimeChat.DelphiObjectClass: TClass;
begin
  Result := TAiMakerAiRealtimeChat;
end;

function TPyDelphiAiMakerAiRealtimeChat.GetDelphiObject: TAiMakerAiRealtimeChat;
begin
  Result := TAiMakerAiRealtimeChat(inherited DelphiObject);
end;

procedure TPyDelphiAiMakerAiRealtimeChat.SetDelphiObject(const Value: TAiMakerAiRealtimeChat);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiRagGraphPostgresDriver }

class function TPyDelphiAiRagGraphPostgresDriver.DelphiObjectClass: TClass;
begin
  Result := TAiRagGraphPostgresDriver;
end;

function TPyDelphiAiRagGraphPostgresDriver.GetDelphiObject: TAiRagGraphPostgresDriver;
begin
  Result := TAiRagGraphPostgresDriver(inherited DelphiObject);
end;

procedure TPyDelphiAiRagGraphPostgresDriver.SetDelphiObject(const Value: TAiRagGraphPostgresDriver);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiRAGVectorPostgresDriver }

class function TPyDelphiAiRAGVectorPostgresDriver.DelphiObjectClass: TClass;
begin
  Result := TAiRAGVectorPostgresDriver;
end;

function TPyDelphiAiRAGVectorPostgresDriver.GetDelphiObject: TAiRAGVectorPostgresDriver;
begin
  Result := TAiRAGVectorPostgresDriver(inherited DelphiObject);
end;

procedure TPyDelphiAiRAGVectorPostgresDriver.SetDelphiObject(const Value: TAiRAGVectorPostgresDriver);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiRAGVectorSQLiteDriver }

class function TPyDelphiAiRAGVectorSQLiteDriver.DelphiObjectClass: TClass;
begin
  Result := TAiRAGVectorSQLiteDriver;
end;

function TPyDelphiAiRAGVectorSQLiteDriver.GetDelphiObject: TAiRAGVectorSQLiteDriver;
begin
  Result := TAiRAGVectorSQLiteDriver(inherited DelphiObject);
end;

procedure TPyDelphiAiRAGVectorSQLiteDriver.SetDelphiObject(const Value: TAiRAGVectorSQLiteDriver);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiMkVecDriver }

class function TPyDelphiAiMkVecDriver.DelphiObjectClass: TClass;
begin
  Result := TAiMkVecDriver;
end;

function TPyDelphiAiMkVecDriver.GetDelphiObject: TAiMkVecDriver;
begin
  Result := TAiMkVecDriver(inherited DelphiObject);
end;

procedure TPyDelphiAiMkVecDriver.SetDelphiObject(const Value: TAiMkVecDriver);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiRAGVectorMSSQLDriver }

class function TPyDelphiAiRAGVectorMSSQLDriver.DelphiObjectClass: TClass;
begin
  Result := TAiRAGVectorMSSQLDriver;
end;

function TPyDelphiAiRAGVectorMSSQLDriver.GetDelphiObject: TAiRAGVectorMSSQLDriver;
begin
  Result := TAiRAGVectorMSSQLDriver(inherited DelphiObject);
end;

procedure TPyDelphiAiRAGVectorMSSQLDriver.SetDelphiObject(const Value: TAiRAGVectorMSSQLDriver);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiOpenAiWebSearchTool }

class function TPyDelphiAiOpenAiWebSearchTool.DelphiObjectClass: TClass;
begin
  Result := TAiOpenAiWebSearchTool;
end;

function TPyDelphiAiOpenAiWebSearchTool.GetDelphiObject: TAiOpenAiWebSearchTool;
begin
  Result := TAiOpenAiWebSearchTool(inherited DelphiObject);
end;

procedure TPyDelphiAiOpenAiWebSearchTool.SetDelphiObject(const Value: TAiOpenAiWebSearchTool);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiOpenAiSpeechTool }

class function TPyDelphiAiOpenAiSpeechTool.DelphiObjectClass: TClass;
begin
  Result := TAiOpenAiSpeechTool;
end;

function TPyDelphiAiOpenAiSpeechTool.GetDelphiObject: TAiOpenAiSpeechTool;
begin
  Result := TAiOpenAiSpeechTool(inherited DelphiObject);
end;

procedure TPyDelphiAiOpenAiSpeechTool.SetDelphiObject(const Value: TAiOpenAiSpeechTool);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiOllamaVisionTool }

class function TPyDelphiAiOllamaVisionTool.DelphiObjectClass: TClass;
begin
  Result := TAiOllamaVisionTool;
end;

function TPyDelphiAiOllamaVisionTool.GetDelphiObject: TAiOllamaVisionTool;
begin
  Result := TAiOllamaVisionTool(inherited DelphiObject);
end;

procedure TPyDelphiAiOllamaVisionTool.SetDelphiObject(const Value: TAiOllamaVisionTool);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAiMemory }

class function TPyDelphiAiMemory.DelphiObjectClass: TClass;
begin
  Result := TAiMemory;
end;

function TPyDelphiAiMemory.GetDelphiObject: TAiMemory;
begin
  Result := TAiMemory(inherited DelphiObject);
end;

procedure TPyDelphiAiMemory.SetDelphiObject(const Value: TAiMemory);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TMakerAiRegistration.Create);

end.
