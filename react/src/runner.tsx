import React from 'react'

interface ConceptRunnerProps {
  concepts: Record<string, React.ComponentType<any>>
  selectedConcept: string
}

export function ConceptRunner({ concepts, selectedConcept }: ConceptRunnerProps) {
  const ConceptComponent = concepts[selectedConcept]
  
  if (!ConceptComponent) {
    return <div>Concept not found: {selectedConcept}</div>
  }

  return (
    <div>
      <h2>{selectedConcept.charAt(0).toUpperCase() + selectedConcept.slice(1)} Concept</h2>
      <ConceptComponent />
    </div>
  )
}