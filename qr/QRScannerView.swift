import SwiftUI
import CodeScanner

struct QRScannerView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String = "未扫描"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("二维码扫描器")
                .font(.largeTitle)
                .padding()
            
            Text("扫描结果: \(scannedCode)")
                .padding()
            
            Button(action: {
                isPresentingScanner = true
            }) {
                Label("开始扫描", systemImage: "qrcode.viewfinder")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(
                codeTypes: [.qr],
                simulatedData: "测试数据",
                completion: handleScan
            )
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isPresentingScanner = false
        switch result {
        case .success(let result):
            scannedCode = result.string
        case .failure(let error):
            print("扫描失败: \(error.localizedDescription)")
            scannedCode = "扫描失败"
        }
    }
}

#Preview {
    QRScannerView()
} 