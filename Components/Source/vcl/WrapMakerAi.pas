(**************************************************************************)
(*  This unit is part of the Python for Delphi (P4D) library              *)
(*  Project home: https://github.com/pyscripter/python4delphi             *)
(*                                                                        *)
(*  Project Maintainer:  PyScripter (pyscripter@gmail.com)                *)
(*  Original Authors:    Dr. Dietmar Budelsky (dbudelsky@web.de)          *)
(*                       Morgan Martinet (https://github.com/mmm-experts) *)
(*  Core developer:      Lucas Belo (lucas.belo@live.com)                 *)
(*  Core developer:      fansxs (admin@gliste.com)                        *)
(*  Contributors:        See contributors.md at project home              *)
(*                                                                        *)
(*  LICENCE and Copyright: MIT (see project home)                         *)
(**************************************************************************)

{$I ..\Definition.Inc}

unit WrapMakerAi;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses, System.JSON,
  System.TypInfo, uMakerAi.ToolFunctions, uMakerAi.Agents,
  uMakerAi.RAG.Vectors, uMakerAi.RAG.Graph.Core, uMakerAi.RAG.Graph.Builder,
  uMakerAi.Utils.VoiceMonitor, UMakerAi.MCPServer.Direct,
  UMakerAi.MCPServer.Stdio, uMakerAi.MCPServer.Core, UMakerAi.MCPServer.Http,
  uMakerAi.Whisper, uMakerAi.Prompts, uMakerAi.Chat.OpenAiResponses,
  uMakerAi.Chat.OpenAi, uMakerAi.Chat.Ollama, uMakerAi.Chat.Mistral,
  uMakerAi.Chat.Groq, uMakerAi.Chat.Grok, uMakerAi.Embeddings.core,
  uMakerAi.Embeddings, uMakerAi.Chat.Gemini, uMakerAi.Chat.DeepSeek,
  uMakerAi.Chat, uMakerAi.Chat.Claude, uMakerAi.Chat.AiConnection;

type
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

  TPyDelphiAiOpenAiResponses = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TAiOpenAiResponses;
    procedure SetDelphiObject(const Value: TAiOpenAiResponses);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAiOpenAiResponses read GetDelphiObject
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
  Result := 'MakerAi';
end;

procedure TMakerAiRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiChatConnection);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiClaudeChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiDeepSeekChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGeminiChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGeminiEmbeddings);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGrokChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiGroqChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMistralChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMistralEmbeddings);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOllamaChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOllamaEmbeddings);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOpenChat);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOpenAiEmbeddings);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiOpenAiResponses);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiPrompts);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAIWhisper);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMCPHttpServer);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMCPStdioServer);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiMCPDirectConnection);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAIVoiceMonitor);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiRagGraphBuilder);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiRagGraph);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiRAGVector);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAIAgents);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAIAgentsNode);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAIAgentsLink);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiAgentsToolSample);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAiFunctions);
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

{ TPyDelphiAiOpenAiResponses }

class function TPyDelphiAiOpenAiResponses.DelphiObjectClass: TClass;
begin
  Result := TAiOpenAiResponses;
end;

function TPyDelphiAiOpenAiResponses.GetDelphiObject: TAiOpenAiResponses;
begin
  Result := TAiOpenAiResponses(inherited DelphiObject);
end;

procedure TPyDelphiAiOpenAiResponses.SetDelphiObject(const Value: TAiOpenAiResponses);
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


initialization
  RegisteredUnits.Add(TMakerAiRegistration.Create);

end.
