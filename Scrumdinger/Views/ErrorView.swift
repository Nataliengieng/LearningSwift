//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by nat on 25/11/2023.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("ERROR!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }
    
    //  initialises an error wrapper with the errorRequired property
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error:SampleError.errorRequired, guidance: "You can ignore this error")
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
