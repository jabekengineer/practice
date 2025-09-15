import React from 'react'

interface ConceptRunnerProps {
  concepts: Record<string, React.ComponentType<unknown>>
  selectedConcept: string
}

export function ConceptRunner({
  concepts,
  selectedConcept,
}: ConceptRunnerProps) {
  const ConceptComponent = concepts[selectedConcept]

  if (!ConceptComponent) {
    return <div>Concept not found: {selectedConcept}</div>
  }

  return (
    <div>
      <ConceptComponent />
    </div>
  )
}
