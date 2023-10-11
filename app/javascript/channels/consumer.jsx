import { createConsumer } from "@rails/actioncable";

const useConsumer = () => {
    const token = btoa(localStorage.getItem('token'))
    return createConsumer(`/cable`)
}

export default useConsumer