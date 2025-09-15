import { useActionState } from 'react';
import { useFormStatus } from 'react-dom';
import { sleep } from '../utils.ts';

/**
 *
 * Hook formSubmit with a custom action that takes in FormData and prevState and progresses to return state
 */

function UseActionState() {
    return (
        <div>
            <RunningSumForm />
        </div>
    );
}

type SumState = {
    sum: number;
    lastInt: number;
    error?: string;
};

async function increment(
    previousState: SumState,
    formData: FormData,
): Promise<SumState> {
    await sleep(500);
    const n = Number(formData.get('sum'));
    if (Number.isNaN(n)) {
        return { ...previousState, error: 'please enter valid number' };
    }
    return { sum: previousState.sum + n, lastInt: n };
}

function RunningSumForm() {
    const [state, formAction, isPending] = useActionState(increment, {
        sum: 0,
        lastInt: 1,
    });
    return (
        <form action={formAction} id='sum-form'>
            <h3>
                Current Sum {isPending && ' Updating…'}: {state.sum}
            </h3>
            {state.error && <p role='alert'> {state.error}</p>}

            <label htmlFor='sum-input' style={{ padding: '20px' }}>
                Amount to add
            </label>
            <input
                type='number'
                name='sum'
                id='sum-input'
                defaultValue={state.lastInt}
            />
            <SubmitButton />
        </form>
    );
}

function SubmitButton() {
    const { pending } = useFormStatus(); // status of the *nearest* form
    return (
        <button type='submit' disabled={pending}>
            {pending ? 'Adding…' : 'Add'}
        </button>
    );
}

export default UseActionState;
