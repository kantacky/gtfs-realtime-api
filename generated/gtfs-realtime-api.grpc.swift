//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: gtfs-realtime-api.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `GtfsRealtimeApi_GTFSRealtimeServiceClient`, then call methods of this protocol to make API calls.
internal protocol GtfsRealtimeApi_GTFSRealtimeServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: GtfsRealtimeApi_GTFSRealtimeServiceClientInterceptorFactoryProtocol? { get }

  func listVehiclePositions(
    _ request: GtfsRealtimeApi_ListVehiclePositionsRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<GtfsRealtimeApi_ListVehiclePositionsRequest, GtfsRealtimeApi_ListVehiclePositionsResponse>
}

extension GtfsRealtimeApi_GTFSRealtimeServiceClientProtocol {
  internal var serviceName: String {
    return "gtfs_realtime_api.GTFSRealtimeService"
  }

  /// Unary call to ListVehiclePositions
  ///
  /// - Parameters:
  ///   - request: Request to send to ListVehiclePositions.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func listVehiclePositions(
    _ request: GtfsRealtimeApi_ListVehiclePositionsRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<GtfsRealtimeApi_ListVehiclePositionsRequest, GtfsRealtimeApi_ListVehiclePositionsResponse> {
    return self.makeUnaryCall(
      path: GtfsRealtimeApi_GTFSRealtimeServiceClientMetadata.Methods.listVehiclePositions.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeListVehiclePositionsInterceptors() ?? []
    )
  }
}

@available(*, deprecated)
extension GtfsRealtimeApi_GTFSRealtimeServiceClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "GtfsRealtimeApi_GTFSRealtimeServiceNIOClient")
internal final class GtfsRealtimeApi_GTFSRealtimeServiceClient: GtfsRealtimeApi_GTFSRealtimeServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: GtfsRealtimeApi_GTFSRealtimeServiceClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: GtfsRealtimeApi_GTFSRealtimeServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the gtfs_realtime_api.GTFSRealtimeService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: GtfsRealtimeApi_GTFSRealtimeServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct GtfsRealtimeApi_GTFSRealtimeServiceNIOClient: GtfsRealtimeApi_GTFSRealtimeServiceClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: GtfsRealtimeApi_GTFSRealtimeServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the gtfs_realtime_api.GTFSRealtimeService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: GtfsRealtimeApi_GTFSRealtimeServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol GtfsRealtimeApi_GTFSRealtimeServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: GtfsRealtimeApi_GTFSRealtimeServiceClientInterceptorFactoryProtocol? { get }

  func makeListVehiclePositionsCall(
    _ request: GtfsRealtimeApi_ListVehiclePositionsRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<GtfsRealtimeApi_ListVehiclePositionsRequest, GtfsRealtimeApi_ListVehiclePositionsResponse>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension GtfsRealtimeApi_GTFSRealtimeServiceAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return GtfsRealtimeApi_GTFSRealtimeServiceClientMetadata.serviceDescriptor
  }

  internal var interceptors: GtfsRealtimeApi_GTFSRealtimeServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeListVehiclePositionsCall(
    _ request: GtfsRealtimeApi_ListVehiclePositionsRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<GtfsRealtimeApi_ListVehiclePositionsRequest, GtfsRealtimeApi_ListVehiclePositionsResponse> {
    return self.makeAsyncUnaryCall(
      path: GtfsRealtimeApi_GTFSRealtimeServiceClientMetadata.Methods.listVehiclePositions.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeListVehiclePositionsInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension GtfsRealtimeApi_GTFSRealtimeServiceAsyncClientProtocol {
  internal func listVehiclePositions(
    _ request: GtfsRealtimeApi_ListVehiclePositionsRequest,
    callOptions: CallOptions? = nil
  ) async throws -> GtfsRealtimeApi_ListVehiclePositionsResponse {
    return try await self.performAsyncUnaryCall(
      path: GtfsRealtimeApi_GTFSRealtimeServiceClientMetadata.Methods.listVehiclePositions.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeListVehiclePositionsInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct GtfsRealtimeApi_GTFSRealtimeServiceAsyncClient: GtfsRealtimeApi_GTFSRealtimeServiceAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: GtfsRealtimeApi_GTFSRealtimeServiceClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: GtfsRealtimeApi_GTFSRealtimeServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

internal protocol GtfsRealtimeApi_GTFSRealtimeServiceClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'listVehiclePositions'.
  func makeListVehiclePositionsInterceptors() -> [ClientInterceptor<GtfsRealtimeApi_ListVehiclePositionsRequest, GtfsRealtimeApi_ListVehiclePositionsResponse>]
}

internal enum GtfsRealtimeApi_GTFSRealtimeServiceClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "GTFSRealtimeService",
    fullName: "gtfs_realtime_api.GTFSRealtimeService",
    methods: [
      GtfsRealtimeApi_GTFSRealtimeServiceClientMetadata.Methods.listVehiclePositions,
    ]
  )

  internal enum Methods {
    internal static let listVehiclePositions = GRPCMethodDescriptor(
      name: "ListVehiclePositions",
      path: "/gtfs_realtime_api.GTFSRealtimeService/ListVehiclePositions",
      type: GRPCCallType.unary
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol GtfsRealtimeApi_GTFSRealtimeServiceProvider: CallHandlerProvider {
  var interceptors: GtfsRealtimeApi_GTFSRealtimeServiceServerInterceptorFactoryProtocol? { get }

  func listVehiclePositions(request: GtfsRealtimeApi_ListVehiclePositionsRequest, context: StatusOnlyCallContext) -> EventLoopFuture<GtfsRealtimeApi_ListVehiclePositionsResponse>
}

extension GtfsRealtimeApi_GTFSRealtimeServiceProvider {
  internal var serviceName: Substring {
    return GtfsRealtimeApi_GTFSRealtimeServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "ListVehiclePositions":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<GtfsRealtimeApi_ListVehiclePositionsRequest>(),
        responseSerializer: ProtobufSerializer<GtfsRealtimeApi_ListVehiclePositionsResponse>(),
        interceptors: self.interceptors?.makeListVehiclePositionsInterceptors() ?? [],
        userFunction: self.listVehiclePositions(request:context:)
      )

    default:
      return nil
    }
  }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol GtfsRealtimeApi_GTFSRealtimeServiceAsyncProvider: CallHandlerProvider, Sendable {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: GtfsRealtimeApi_GTFSRealtimeServiceServerInterceptorFactoryProtocol? { get }

  func listVehiclePositions(
    request: GtfsRealtimeApi_ListVehiclePositionsRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> GtfsRealtimeApi_ListVehiclePositionsResponse
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension GtfsRealtimeApi_GTFSRealtimeServiceAsyncProvider {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return GtfsRealtimeApi_GTFSRealtimeServiceServerMetadata.serviceDescriptor
  }

  internal var serviceName: Substring {
    return GtfsRealtimeApi_GTFSRealtimeServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  internal var interceptors: GtfsRealtimeApi_GTFSRealtimeServiceServerInterceptorFactoryProtocol? {
    return nil
  }

  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "ListVehiclePositions":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<GtfsRealtimeApi_ListVehiclePositionsRequest>(),
        responseSerializer: ProtobufSerializer<GtfsRealtimeApi_ListVehiclePositionsResponse>(),
        interceptors: self.interceptors?.makeListVehiclePositionsInterceptors() ?? [],
        wrapping: { try await self.listVehiclePositions(request: $0, context: $1) }
      )

    default:
      return nil
    }
  }
}

internal protocol GtfsRealtimeApi_GTFSRealtimeServiceServerInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when handling 'listVehiclePositions'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeListVehiclePositionsInterceptors() -> [ServerInterceptor<GtfsRealtimeApi_ListVehiclePositionsRequest, GtfsRealtimeApi_ListVehiclePositionsResponse>]
}

internal enum GtfsRealtimeApi_GTFSRealtimeServiceServerMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "GTFSRealtimeService",
    fullName: "gtfs_realtime_api.GTFSRealtimeService",
    methods: [
      GtfsRealtimeApi_GTFSRealtimeServiceServerMetadata.Methods.listVehiclePositions,
    ]
  )

  internal enum Methods {
    internal static let listVehiclePositions = GRPCMethodDescriptor(
      name: "ListVehiclePositions",
      path: "/gtfs_realtime_api.GTFSRealtimeService/ListVehiclePositions",
      type: GRPCCallType.unary
    )
  }
}